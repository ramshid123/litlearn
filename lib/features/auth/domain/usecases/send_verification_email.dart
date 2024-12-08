import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';

class UseCaseSendVerificationEmail
    implements Usecase<void, UseCaseSendVerificationEmailParams> {
  final AuthRepository authRepository;

  UseCaseSendVerificationEmail(this.authRepository);
  @override
  Future<Either<KFailure, void>> call(
      UseCaseSendVerificationEmailParams params) async {
    return await authRepository.sendVerificationEmail();
  }
}

class UseCaseSendVerificationEmailParams {}
