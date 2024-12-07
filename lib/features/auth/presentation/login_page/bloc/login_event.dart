part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginEventSignup extends LoginEvent {
  final String email;
  final String password;
  final String fullname;

  LoginEventSignup(
      {required this.email, required this.password, required this.fullname});
}

final class LoginEventLogin extends LoginEvent {
  final String email;
  final String password;

  LoginEventLogin({required this.email, required this.password});
}

final class LoginEventForgotPassword extends LoginEvent {
  final String email;

  LoginEventForgotPassword(this.email);
}
