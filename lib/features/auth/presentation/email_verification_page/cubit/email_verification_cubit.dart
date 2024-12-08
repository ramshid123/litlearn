import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlearn/features/auth/domain/usecases/check_email_verified.dart';
import 'package:litlearn/features/auth/domain/usecases/logout.dart';
import 'package:litlearn/features/auth/domain/usecases/send_verification_email.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final UseCaseCheckEmailVerified _useCaseCheckEmailVerified;
  final UseCaseLogout _useCaseLogout;
  final UseCaseSendVerificationEmail _useCaseSendVerificationEmail;

  EmailVerificationCubit({
    required UseCaseCheckEmailVerified useCaseCheckEmailVerified,
    required UseCaseSendVerificationEmail useCaseSendVerificationEmail,
    required UseCaseLogout useCaseLogout,
  })  : _useCaseCheckEmailVerified = useCaseCheckEmailVerified,
        _useCaseSendVerificationEmail = useCaseSendVerificationEmail,
        _useCaseLogout = useCaseLogout,
        super(EmailVerificationInitial());

  Future checkForEmailVerification({required bool sendEmail}) async {
    final response =
        await _useCaseCheckEmailVerified(UseCaseCheckEmailVerifiedParams());

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        emit(EmailVerificationStateStatus(status: r, sendMail: sendEmail));
      },
    );
  }

  Future logout() async {
    final response = await _useCaseLogout(UseCaseLogoutParams());

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        emit(EmailVerificationStateLogout());
      },
    );
  }

  Future sendVerificationEmail() async {
    final response = await _useCaseSendVerificationEmail(
        UseCaseSendVerificationEmailParams());

    response.fold(
      (l) {
        log(l.message);
        if (l.message.contains('too-many-requests')) {
          emit(EmailVerificationStateFailure(
              'Too many requests. Please try again later.'));
        } else {
          emit(EmailVerificationStateFailure('Something went wrong'));
        }
      },
      (r) {
        emit(EmailVerificationStateSentEmail());
      },
    );
  }
}
