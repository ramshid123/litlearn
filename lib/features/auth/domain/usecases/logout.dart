import 'package:fpdart/fpdart.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';

class UseCaseLogout implements Usecase<void, UseCaseLogoutParams> {
  final AuthRepository authRepository;

  UseCaseLogout(this.authRepository);

  @override
  Future<Either<KFailure, void>> call(UseCaseLogoutParams params) async {
    return await authRepository.logout();
  }
}

class UseCaseLogoutParams {}
