import 'package:cloud_firestore/cloud_firestore.dart';

class CourseEntity {
  final String courseId;
  final String courseName;
  final List<String> videoIds;
  final String totalVideoCounts;
  final Timestamp createdAt;
  final String category;
  final String totalVideoHours;
  final String thumbnailUrl;
  final String language;
  final String teacherName;
  final String teacherDesc;

  CourseEntity(
      {required this.teacherName,
      required this.teacherDesc,
      required this.courseId,
      required this.courseName,
      required this.videoIds,
      required this.totalVideoCounts,
      required this.createdAt,
      required this.category,
      required this.totalVideoHours,
      required this.thumbnailUrl,
      required this.language});
}
