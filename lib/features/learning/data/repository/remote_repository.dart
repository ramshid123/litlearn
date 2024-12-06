import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/entity/enrolled_course_entity.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/core/error/exception.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/features/learning/data/data%20source/remote_datasource.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class LearningRemoteRepositoryImpl implements LearningRemoteRepository {
  final LearningRemoteDataSource learningRemoteDataSource;

  LearningRemoteRepositoryImpl(this.learningRemoteDataSource);

  @override
  Future<Either<KFailure, List<CourseEntity>>> getCourses() async {
    try {
      final response = await learningRemoteDataSource.getCourses();
      return right(response);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, CourseEntity>> getCourseById(String courseId) async {
    try {
      final response = await learningRemoteDataSource.getCourseById(courseId);
      return right(response);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, VideoEntity>> getVideoById(String videoId) async {
    try {
      final response = await learningRemoteDataSource.getVideoById(videoId);
      return right(response);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, EnrolledCourseEntity?>> getEnrolledCourseById(
      {required String courseId, required String userId}) async {
    try {
      final response = await learningRemoteDataSource.getEnrolledCourse(
          courseId: courseId, userId: userId);

      return right(response);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, void>> enrollCourse(
      {required String courseId, required String userId}) async {
    try {
      final enrolledCourse = await learningRemoteDataSource.getEnrolledCourse(
          courseId: courseId, userId: userId);

      if (enrolledCourse == null) {
        await learningRemoteDataSource.enrollCourse(
            courseId: courseId, userId: userId);
      }

      return right(null);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }
}