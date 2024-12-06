import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class UseCaseGetCourseById
    implements Usecase<CourseEntity, UseCaseGetCourseByIdParams> {
  final LearningRemoteRepository learningRemoteRepository;

  UseCaseGetCourseById(this.learningRemoteRepository);

  @override
  Future<Either<KFailure, CourseEntity>> call(
      UseCaseGetCourseByIdParams params) async {
    return await learningRemoteRepository.getCourseById(params.courseId);
  }
}

class UseCaseGetCourseByIdParams {
  final String courseId;

  UseCaseGetCourseByIdParams(this.courseId);
}
