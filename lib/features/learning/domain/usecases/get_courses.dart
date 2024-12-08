import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class UseCaseGetCourses
    implements Usecase<List<CourseEntity>, UseCaseGetCoursesParams> {
  final LearningRemoteRepository learningRemoteRepository;

  UseCaseGetCourses(this.learningRemoteRepository);

  @override
  Future<Either<KFailure, List<CourseEntity>>> call(
          UseCaseGetCoursesParams params) async =>
      await learningRemoteRepository.getCourses(params.category);
}

class UseCaseGetCoursesParams {
  final String? category;

  UseCaseGetCoursesParams(this.category);
}
