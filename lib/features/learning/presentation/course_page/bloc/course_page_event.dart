part of 'course_page_bloc.dart';

@immutable
sealed class CoursePageEvent {}

final class CoursePageEventGetCourseById extends CoursePageEvent {
  final String courseId;

  CoursePageEventGetCourseById(this.courseId);
}
