import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';

class UseCaseUpdateUserData
    implements Usecase<UserEntity, UseCaseUpdateUserDataParams> {
  final AuthRepository authRepository;

  UseCaseUpdateUserData(this.authRepository);

  @override
  Future<Either<KFailure, UserEntity>> call(
      UseCaseUpdateUserDataParams params) async {
    return await authRepository.updateUserData(params.user);
  }
}

class UseCaseUpdateUserDataParams {
  final UserEntity user;

  UseCaseUpdateUserDataParams(this.user);
}
