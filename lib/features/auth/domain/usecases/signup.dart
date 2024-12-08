import 'package:fpdart/fpdart.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';

class UseCaseSignup implements Usecase<UserEntity, UseCaseSignupParams> {
  final AuthRepository authRepository;

  UseCaseSignup(this.authRepository);

  @override
  Future<Either<KFailure, UserEntity>> call(UseCaseSignupParams params) async {
    return await authRepository.signup(
      email: params.email,
      password: params.password,
      fullname: params.fullname,
    );
  }
}

class UseCaseSignupParams {
  final String fullname;
  final String email;
  final String password;

  UseCaseSignupParams(
      {required this.fullname,
      required this.email,
      required this.password});
}
