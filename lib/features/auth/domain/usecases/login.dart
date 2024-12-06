import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';

class UseCaseLogin implements Usecase<UserEntity?, UseCaseLoginParams> {
  final AuthRepository authRepository;

  UseCaseLogin(this.authRepository);

  @override
  Future<Either<KFailure, UserEntity?>> call(UseCaseLoginParams params) async {
    return await authRepository.login(
        email: params.email, password: params.password);
  }
}

class UseCaseLoginParams {
  final String email;
  final String password;

  UseCaseLoginParams({required this.email, required this.password});
}
