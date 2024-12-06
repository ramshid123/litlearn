import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class UseCaseEnrollCourse implements Usecase<void, UseCaseEnrollCourseParams> {
  final LearningRemoteRepository learningRemoteRepository;

  UseCaseEnrollCourse(this.learningRemoteRepository);

  @override
  Future<Either<KFailure, void>> call(UseCaseEnrollCourseParams params) async {
    return await learningRemoteRepository.enrollCourse(
        courseId: params.courseId, userId: params.userId);
  }
}

class UseCaseEnrollCourseParams {
  final String userId;
  final String courseId;

  UseCaseEnrollCourseParams({required this.userId, required this.courseId});
}
