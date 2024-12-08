part of 'email_verification_cubit.dart';

@immutable
sealed class EmailVerificationState {}

final class EmailVerificationInitial extends EmailVerificationState {}

final class EmailVerificationStateLoading extends EmailVerificationState {}

final class EmailVerificationStateSentEmail extends EmailVerificationState {}

final class EmailVerificationStateFailure extends EmailVerificationState {
  final String msg;

  EmailVerificationStateFailure(this.msg);
}

final class EmailVerificationStateLogout extends EmailVerificationState {}

final class EmailVerificationStateStatus extends EmailVerificationState {
  final bool status;
  final bool sendMail;

  EmailVerificationStateStatus({required this.status, required this.sendMail});
}
