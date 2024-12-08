import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/error/exception.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/features/auth/data/data%20source/auth_data_service.dart';
import 'package:litlearn/features/auth/data/data%20source/auth_data_source.dart';
import 'package:litlearn/features/auth/data/model/user_model.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authService, required this.authDataSource});

  @override
  Future<Either<KFailure, UserEntity?>> login(
      {required String email, required String password}) async {
    try {
      final userCheck = await authDataSource.getUserData(email);

      if (userCheck != null) {
        await authService.login(email: email, password: password);
        return right(userCheck);
      } else {
        return right(null);
      }
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, UserModel>> signup({
    required String email,
    required String password,
    required String fullname,
  }) async {
    try {
      final response =
          await authService.signup(email: email, password: password);

      await authDataSource.registerUser(UserModel(
          userId: response,
          fullName: fullname,
          dob: '',
          gender: '',
          profilePicUrl: '',
          createdAt: Timestamp.fromDate(DateTime.now()),
          email: email,
          phoneNo: '',
          password: password));

      final userData = await authDataSource.getUserData(email);

      return right(userData!);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, UserModel?>> getCurrentUser() async {
    try {
      final user = await authService.getCurrentUser();
      if (user == null) {
        return right(null);
      } else {
        final res = await authDataSource.getUserData(user.email!);
        if (res == null) {
          return right(null);
        } else {
          return right(res);
        }
      }
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, void>> logout() async {
    try {
      await authService.logout();
      return right(null);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, UserEntity>> updateUserData(UserEntity user) async {
    try {
      await authDataSource.updateUser(UserModel.fromEntity(user));
      final userData = await authDataSource.getUserData(user.email);
      return right(userData!);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, void>> sendResetPasswordEmail(String email) async {
    try {
      await authService.sendPasswordResetEmail(email);
      return right(null);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, bool>> emailVerificationCheck() async {
    try {
      final response = await authService.checkEmailVerification();
      return right(response);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, void>> sendVerificationEmail() async {
    try {
      await authService.sendVerificationEmail();
      return right(null);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }
}
