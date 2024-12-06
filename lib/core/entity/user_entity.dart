import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String userId;
  final String fullName;
  final String dob;
  final String gender;
  final String profilePicUrl;
  final Timestamp createdAt;
  final String email;
  final String phoneNo;
  final String password;

  UserEntity(
      {required this.userId,
      required this.fullName,
      required this.dob,
      required this.gender,
      required this.profilePicUrl,
      required this.createdAt,
      required this.email,
      required this.phoneNo,
      required this.password});
}
