import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:litlearn/core/entity/course_entity.dart';

class CourseModel extends CourseEntity {
  CourseModel({
    required super.courseId,
    required super.courseName,
    required super.videoIds,
    required super.totalVideoCounts,
    required super.createdAt,
    required super.category,
    required super.totalVideoHours,
    required super.thumbnailUrl,
    required super.language,
    required super.teacherDesc,
    required super.teacherName,
  });

  factory CourseModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return CourseModel(
      courseId: json.data()['course_id'],
      courseName: json.data()['course_name'],
      videoIds: List<String>.from(json.data()['video_ids']),
      totalVideoCounts: json.data()['total_video_count'],
      createdAt: json.data()['created_at'],
      category: json.data()['category'],
      totalVideoHours: json.data()['total_video_hours'],
      thumbnailUrl: json.data()['thumbnail_url'],
      language: json.data()['language'],
      teacherName: json.data()['teacher_name'],
      teacherDesc: json.data()['teacher_desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'course_name': courseName,
      'video_ids': videoIds,
      'total_video_count': totalVideoCounts,
      'created_at': createdAt,
      'category': category,
      'total_video_hours': totalVideoHours,
      'thumbnail_url': thumbnailUrl,
      'language': language,
      'teacher_name': teacherName,
      'teacher_desc': teacherDesc,
    };
  }

  factory CourseModel.fromEntity(CourseEntity courseEntity) {
    return CourseModel(
      courseId: courseEntity.courseId,
      courseName: courseEntity.courseName,
      videoIds: courseEntity.videoIds,
      totalVideoCounts: courseEntity.totalVideoCounts,
      createdAt: courseEntity.createdAt,
      category: courseEntity.category,
      totalVideoHours: courseEntity.totalVideoHours,
      thumbnailUrl: courseEntity.thumbnailUrl,
      language: courseEntity.language,
      teacherDesc: courseEntity.teacherDesc,
      teacherName: courseEntity.teacherName,
    );
  }
}
