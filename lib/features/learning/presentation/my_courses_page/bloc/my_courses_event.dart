part of 'my_courses_bloc.dart';

@immutable
sealed class MyCoursesEvent {}

final class MyCoursesEventFetchCourses extends MyCoursesEvent {
  final String userId;

  MyCoursesEventFetchCourses(this.userId);
}
