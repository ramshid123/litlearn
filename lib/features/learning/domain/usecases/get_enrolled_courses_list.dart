import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class UseCaseGetEnrolledCoursesList
    implements
        Usecase<List<CourseEntity>, UseCaseGetEnrolledCoursesListParams> {
  final LearningRemoteRepository learningRemoteRepository;

  UseCaseGetEnrolledCoursesList(this.learningRemoteRepository);

  @override
  Future<Either<KFailure, List<CourseEntity>>> call(
      UseCaseGetEnrolledCoursesListParams params) async {
    return await learningRemoteRepository.getEnrolledCoursesList(params.userId);
  }
}

class UseCaseGetEnrolledCoursesListParams {
  final String userId;

  UseCaseGetEnrolledCoursesListParams(this.userId);
}
