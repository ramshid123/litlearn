import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';

class UseCaseCheckEmailVerified
    implements Usecase<bool, UseCaseCheckEmailVerifiedParams> {
  final AuthRepository authRepository;

  UseCaseCheckEmailVerified(this.authRepository);

  @override
  Future<Either<KFailure, bool>> call(
      UseCaseCheckEmailVerifiedParams params) async {
    return await authRepository.emailVerificationCheck();
  }
}

class UseCaseCheckEmailVerifiedParams {}
