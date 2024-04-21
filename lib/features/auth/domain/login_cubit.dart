import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackify/core/service/auth_service.dart';

import '../../../core/injection/locator.dart';
//import 'login_service.dart';

class LoginCubit extends Cubit<LoginState> {
 late final IAuthService _loginService;

  LoginCubit() : super(LoginState(InitialEvent())) {
   _loginService = getIt.get<IAuthService>();
  }

  Future<void> login(
    String email,
    String password,
  ) async {
     try {
      emit(state.copyWith(loginEvent: LoadingEvent()));
      await _loginService.signIn(email, password);
      emit(state.copyWith(loginEvent: SuccessfulLoginEvent()));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(loginEvent: FailedLoginEvent(message: e.message.toString())));
    }
  }

}

abstract class LoginEvent {}

class InitialEvent extends LoginEvent {}

class SuccessfulLoginEvent extends LoginEvent {}

class LoadingEvent extends LoginEvent {}

class FailedLoginEvent extends LoginEvent {
  final String message;
  FailedLoginEvent({this.message = "Something went wrong"});
}

class LoginState {
  final LoginEvent loginEvent;

  LoginState(this.loginEvent);

  LoginState copyWith({
    bool? hasError,
    LoginEvent? loginEvent,
  }) {
    return LoginState(loginEvent ?? this.loginEvent);
  }
}
