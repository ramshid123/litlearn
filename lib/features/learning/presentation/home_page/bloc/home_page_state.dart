part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class HomePageStateFailure extends HomePageState {
  final String error;

  HomePageStateFailure(this.error);
}

final class HomePageStateCourses extends HomePageState {
  final List<CourseEntity> courses;

  HomePageStateCourses(this.courses);
}

final class HomePageStateCourseLoading extends HomePageState {}


