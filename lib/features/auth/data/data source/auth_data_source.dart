import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlearn/core/constants/collections.dart';
import 'package:litlearn/core/error/exception.dart';
import 'package:litlearn/features/auth/data/model/user_model.dart';

abstract interface class AuthDataSource {
  Future<UserModel?> getUserData(String email);

  Future registerUser(UserModel user);

  Future updateUser(UserModel user);
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseFirestore firestoreDB;

  AuthDataSourceImpl(this.firestoreDB);

  @override
  Future<UserModel?> getUserData(String email) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.users)
          .where('email', isEqualTo: email)
          .get();

      if (response.docs.isEmpty) {
        return null;
      } else {
        return UserModel.fromJson(response.docs.first);
      }
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future registerUser(UserModel user) async {
    try {
      await firestoreDB
          .collection(FirestoreCollections.users)
          .add(user.toJson());
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future updateUser(UserModel user) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.users)
          .where('email', isEqualTo: user.email)
          .get();

      if (response.docs.isNotEmpty) {
        await response.docs.first.reference.update({
          'full_name': user.fullName.isEmpty
              ? response.docs.first.data()['full_name']
              : user.fullName,
          'phone_no': user.phoneNo.isEmpty
              ? response.docs.first.data()['phone_no']
              : user.phoneNo,
          'dob':
              user.dob.isEmpty ? response.docs.first.data()['dob'] : user.dob,
          'gender': user.gender.isEmpty
              ? response.docs.first.data()['gender']
              : user.gender,
        });
      }
    } catch (e) {
      throw KustomException(e.toString());
    }
  }
}
