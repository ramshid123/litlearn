import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlearn/core/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.userId,
      required super.fullName,
      required super.dob,
      required super.gender,
      required super.profilePicUrl,
      required super.createdAt,
      required super.email,
      required super.phoneNo,
      required super.password});

  factory UserModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return UserModel(
      userId: json.data()['user_id'],
      fullName: json.data()['full_name'],
      dob: json.data()['dob'],
      gender: json.data()['gender'],
      profilePicUrl: json.data()['profile_pic_url'],
      createdAt: json.data()['createdAt'],
      email: json.data()['email'],
      phoneNo: json.data()['phone_no'],
      password: json.data()['password'],
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      userId: entity.userId,
      fullName: entity.fullName,
      dob: entity.dob,
      gender: entity.gender,
      profilePicUrl: entity.profilePicUrl,
      createdAt: entity.createdAt,
      email: entity.email,
      phoneNo: entity.phoneNo,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'dob': dob,
      'gender': gender,
      'profile_pic_url': profilePicUrl,
      'createdAt': createdAt,
      'email': email,
      'phone_no': phoneNo,
      'password': password,
    };
  }
}
