import 'package:uuid/uuid.dart' as uuid;
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlearn/core/constants/collections.dart';
import 'package:litlearn/core/error/exception.dart';
import 'package:litlearn/features/learning/data/models/course_model.dart';
import 'package:litlearn/features/learning/data/models/enrolled_course_model.dart';
import 'package:litlearn/features/learning/data/models/video_model.dart';

abstract interface class LearningRemoteDataSource {
  Future<List<CourseModel>> getCourses();

  Future<CourseModel> getCourseById(String courseId);

  Future<VideoModel> getVideoById(String videoId);

  Future<EnrolledCourseModel?> getEnrolledCourse(
      {required String courseId, required String userId});

  Future enrollCourse({required String courseId, required String userId});
}

class LearningRemoteDataSourceImpl implements LearningRemoteDataSource {
  final FirebaseFirestore firestoreDB;

  LearningRemoteDataSourceImpl(this.firestoreDB);

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final response =
          await firestoreDB.collection(FirestoreCollections.courses).get();
      return response.docs.map((e) => CourseModel.fromJson(e)).toList();
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<CourseModel> getCourseById(String courseId) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.courses)
          .where('course_id', isEqualTo: courseId)
          .get();
      return CourseModel.fromJson(response.docs.first);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<VideoModel> getVideoById(String videoId) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.videos)
          .where('video_id', isEqualTo: videoId)
          .get();

      return VideoModel.fromJson(response.docs.first);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<EnrolledCourseModel?> getEnrolledCourse(
      {required String courseId, required String userId}) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.enrolledCourses)
          .where('user_id', isEqualTo: userId)
          .where('course_id', isEqualTo: courseId)
          .get();

      if (response.docs.isEmpty) {
        return null;
      } else {
        return EnrolledCourseModel.fromJson(response.docs.first);
      }
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future enrollCourse(
      {required String courseId, required String userId}) async {
    try {
      final collection =
          firestoreDB.collection(FirestoreCollections.enrolledCourses);

      final newDoc = collection.doc();

      final response = await newDoc.set(EnrolledCourseModel(
        id: '${userId}_${DateTime.now().millisecondsSinceEpoch}_${const uuid.Uuid().v1()}',
        courseId: courseId,
        unlockCount: 0,
        userId: userId,
        enrolledAt: Timestamp.fromDate(DateTime.now()),
      ).toJson());

      return null;
    } catch (e) {
      throw KustomException(e.toString());
    }
  }
}