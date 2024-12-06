import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlearn/core/entity/enrolled_course_entity.dart';

class EnrolledCourseModel extends EnrolledCourseEntity {
  EnrolledCourseModel(
      {required super.id,
      required super.courseId,
      required super.unlockCount,
      required super.userId,
      required super.enrolledAt});

  factory EnrolledCourseModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return EnrolledCourseModel(
      id: json.data()['id'],
      courseId: json.data()['course_id'],
      unlockCount: json.data()['unlock_count'],
      userId: json.data()['user_id'],
      enrolledAt: json.data()['enrolled_at'],
    );
  }

  factory EnrolledCourseModel.fromEntity(EnrolledCourseEntity entity) {
    return EnrolledCourseModel(
      id: entity.id,
      courseId: entity.courseId,
      unlockCount: entity.unlockCount,
      userId: entity.userId,
      enrolledAt: entity.enrolledAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'unlock_count': unlockCount,
      'user_id': userId,
      'enrolled_at': enrolledAt,
    };
  }
}
