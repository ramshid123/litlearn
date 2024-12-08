import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/get_courses.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final UseCaseGetCourses _useCaseGetCourses;

  HomePageBloc({
    required UseCaseGetCourses useCaseGetCourses,
  })  : _useCaseGetCourses = useCaseGetCourses,
        super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      
    });

    on<HomePageEventGetCourses>(
        (event, emit) async => await _onHomePageEventGetCourses(event, emit));
  }

  Future _onHomePageEventGetCourses(
      HomePageEventGetCourses event, Emitter<HomePageState> emit) async {
    emit(HomePageStateCourseLoading());
    final response =
        await _useCaseGetCourses(UseCaseGetCoursesParams(event.category));

    response.fold(
      (l) {
        log(l.message);
        emit(HomePageStateFailure(l.message));
      },
      (r) {
        emit(HomePageStateCourses(r));
      },
    );
  }
}
