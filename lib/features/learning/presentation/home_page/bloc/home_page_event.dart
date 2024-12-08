part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

final class HomePageEventGetCourses extends HomePageEvent {
  final String? category;

  HomePageEventGetCourses(this.category);
}

