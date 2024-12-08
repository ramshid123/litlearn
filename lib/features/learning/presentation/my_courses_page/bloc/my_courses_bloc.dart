import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/get_enrolled_courses_list.dart';

part 'my_courses_event.dart';
part 'my_courses_state.dart';

class MyCoursesBloc extends Bloc<MyCoursesEvent, MyCoursesState> {
  final UseCaseGetEnrolledCoursesList _useCaseGetEnrolledCoursesList;

  MyCoursesBloc({
    required UseCaseGetEnrolledCoursesList useCaseGetEnrolledCoursesList,
  })  : _useCaseGetEnrolledCoursesList = useCaseGetEnrolledCoursesList,
        super(MyCoursesInitial()) {
    on<MyCoursesEvent>((event, emit) {
      
    });

    on<MyCoursesEventFetchCourses>((event, emit) async =>
        await _onMyCoursesEventFetchCourses(event, emit));
  }

  Future _onMyCoursesEventFetchCourses(
      MyCoursesEventFetchCourses event, Emitter<MyCoursesState> emit) async {
        emit(MyCoursesStateLoading());
        
    final response = await _useCaseGetEnrolledCoursesList(
        UseCaseGetEnrolledCoursesListParams(event.userId));

    response.fold(
      (l) {
        log(l.message);
        emit(MyCoursesStateFailure(l.message));
      },
      (r) {
        emit(MyCoursesStateEnrolledCourses(r));
      },
    );
  }
}
