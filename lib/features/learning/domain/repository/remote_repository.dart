import 'package:fpdart/fpdart.dart';
import 'package:litlearn/core/entity/enrolled_course_entity.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/entity/course_entity.dart';

abstract interface class LearningRemoteRepository {
  Future<Either<KFailure, List<CourseEntity>>> getCourses();

  Future<Either<KFailure, CourseEntity>> getCourseById(String courseId);

  Future<Either<KFailure, VideoEntity>> getVideoById(String videoId);

  Future<Either<KFailure, EnrolledCourseEntity?>> getEnrolledCourseById(
      {required String courseId, required String userId});

  Future<Either<KFailure, void>> enrollCourse(
      {required String courseId, required String userId});
}
