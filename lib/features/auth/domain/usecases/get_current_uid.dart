import 'package:fpdart/fpdart.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';

class UseCaseGetCurrentUid
    implements Usecase<UserEntity?, UseCaseGetCurrentUidParams> {
  final AuthRepository authRepository;

  UseCaseGetCurrentUid(this.authRepository);

  @override
  Future<Either<KFailure, UserEntity?>> call(
      UseCaseGetCurrentUidParams params) async {
    return await authRepository.getCurrentUser();
  }
}

class UseCaseGetCurrentUidParams {}
