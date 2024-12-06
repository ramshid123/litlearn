import 'package:cloud_firestore/cloud_firestore.dart';

class EnrolledCourseEntity {
  final String id;
  final String courseId;
  final int unlockCount;
  final String userId;
  final Timestamp enrolledAt;

  EnrolledCourseEntity(
      {required this.id,
      required this.courseId,
      required this.unlockCount,
      required this.userId,
      required this.enrolledAt});
}
