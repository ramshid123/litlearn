part of 'course_page_bloc.dart';

@immutable
sealed class CoursePageState {}

final class CoursePageInitial extends CoursePageState {}

final class CoursePageStateFailure extends CoursePageState {
  final String errorMsg;

  CoursePageStateFailure(this.errorMsg);
}

final class CoursePageStateCourse extends CoursePageState {
  final CourseEntity course;

  CoursePageStateCourse(this.course);
}

final class CoursePageStateLoading extends CoursePageState {}
