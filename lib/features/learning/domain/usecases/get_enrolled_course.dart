import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/entity/enrolled_course_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class UseCaseGetEnrolledCourse
    implements Usecase<EnrolledCourseEntity?, UseCaseGetEnrolledCourseParams> {
  final LearningRemoteRepository learningRemoteRepository;

  UseCaseGetEnrolledCourse(this.learningRemoteRepository);

  @override
  Future<Either<KFailure, EnrolledCourseEntity?>> call(
      UseCaseGetEnrolledCourseParams params) async {
    return await learningRemoteRepository.getEnrolledCourseById(
        courseId: params.courseId, userId: params.userId);
  }
}

class UseCaseGetEnrolledCourseParams {
  final String userId;
  final String courseId;

  UseCaseGetEnrolledCourseParams(
      {required this.userId, required this.courseId});
}
