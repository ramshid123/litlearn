import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlearn/core/entity/enrolled_course_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/enroll_course.dart';
import 'package:litlearn/features/learning/domain/usecases/get_enrolled_course.dart';

class EnrolledCourseCubit extends Cubit<EnrolledCourseEntity?> {
  final UseCaseGetEnrolledCourse _useCaseGetEnrolledCourse;
  final UseCaseEnrollCourse _useCaseEnrollCourse;

  EnrolledCourseCubit(
      {required UseCaseGetEnrolledCourse useCaseGetEnrolledCourse,
      required UseCaseEnrollCourse useCaseEnrollCourse})
      : _useCaseGetEnrolledCourse = useCaseGetEnrolledCourse,
        _useCaseEnrollCourse = useCaseEnrollCourse,
        super(null);

  Future enrollCourse(
      {required String userId, required String courseId}) async {
    final response = await _useCaseEnrollCourse(
        UseCaseEnrollCourseParams(userId: userId, courseId: courseId));

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {},
    );
  }

  Future getEnrolledStatus(
      {required String userId, required String courseId}) async {
    final response = await _useCaseGetEnrolledCourse(
        UseCaseGetEnrolledCourseParams(userId: userId, courseId: courseId));

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        emit(r);
      },
    );
  }
}
