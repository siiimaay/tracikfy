import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackify/core/service/auth_service.dart';

import 'package:injectable/injectable.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final IAuthService _loginService;

  SignUpCubit(this._loginService) : super(SignUpState(InitialEvent()));

  void createAccount(
      String email,
      String password,
      String phoneNumber,
      String country,
      ) async {
   try {
      emit(state.copyWith(registerEvent: LoadingEvent()));
      await _loginService.signUp(
        email,
        password,
        phoneNumber,
        country,
      );
      emit(state.copyWith(registerEvent: SuccessfulRegister()));
    } on FirebaseAuthException catch (e) {
     emit(state.copyWith(
         hasError: true,
         registerEvent: FailedRegister(message: e.message.toString()),
     ));

    }
  }
}

abstract class RegisterEvent {}

class InitialEvent extends RegisterEvent {}

class SuccessfulRegister extends RegisterEvent {}

class LoadingEvent extends RegisterEvent {}

class FailedRegister extends RegisterEvent {
  final String message;
  FailedRegister({this.message = 'Something went wrong'});
}

class SignUpState {
  final RegisterEvent registerEvent;

  SignUpState(this.registerEvent);

  SignUpState copyWith({
    bool? hasError,
    RegisterEvent? registerEvent,
  }) {
    return SignUpState(registerEvent ?? this.registerEvent);
  }
}

