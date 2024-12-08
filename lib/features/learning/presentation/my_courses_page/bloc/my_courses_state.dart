part of 'my_courses_bloc.dart';

@immutable
sealed class MyCoursesState {}

final class MyCoursesInitial extends MyCoursesState {}

final class MyCoursesStateLoading extends MyCoursesState {}

final class MyCoursesStateEnrolledCourses extends MyCoursesState {
  final List<CourseEntity> courses;

  MyCoursesStateEnrolledCourses(this.courses);
}

final class MyCoursesStateFailure extends MyCoursesState {
  final String msg;

  MyCoursesStateFailure(this.msg);
}
