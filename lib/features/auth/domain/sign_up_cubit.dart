import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackify/core/service/auth_service.dart';

import '../../../core/injection/locator.dart';
import 'login_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
   final IAuthService _loginService ;

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
    } catch (e) {
      emit(state.copyWith(
        hasError: true,
        registerEvent: FailedRegister(),
      ));
    }
  }
}

abstract class RegisterEvent {}

class InitialEvent extends RegisterEvent {}

class SuccessfulRegister extends RegisterEvent {}

class LoadingEvent extends RegisterEvent {}

class FailedRegister extends RegisterEvent {}

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
