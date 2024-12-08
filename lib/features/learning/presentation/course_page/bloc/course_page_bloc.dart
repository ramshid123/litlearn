import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/get_course_by_id.dart';

part 'course_page_event.dart';
part 'course_page_state.dart';

class CoursePageBloc extends Bloc<CoursePageEvent, CoursePageState> {
  final UseCaseGetCourseById _useCaseGetCourseById;

  CoursePageBloc({
    required UseCaseGetCourseById useCaseGetCourseById,
  })  : _useCaseGetCourseById = useCaseGetCourseById,
        super(CoursePageInitial()) {
    on<CoursePageEvent>((event, emit) {
      emit(CoursePageStateLoading());
    });

    on<CoursePageEventGetCourseById>((event, emit) async =>
        await _onCoursePageEventGetCourseById(event, emit));


  }

  Future _onCoursePageEventGetCourseById(
      CoursePageEventGetCourseById event, Emitter<CoursePageState> emit) async {
    final response =
        await _useCaseGetCourseById(UseCaseGetCourseByIdParams(event.courseId));

    response.fold(
      (l) {
        log(l.message);
        emit(CoursePageStateFailure(l.message));
      },
      (r) {
        emit(CoursePageStateCourse(r));
      },
    );
  }


}
