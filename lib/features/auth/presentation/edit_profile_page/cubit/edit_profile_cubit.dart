import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/features/auth/domain/usecases/update_user_data.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UseCaseUpdateUserData _useCaseUpdateUserData;

  EditProfileCubit({required UseCaseUpdateUserData useCaseUpdateUserData})
      : _useCaseUpdateUserData = useCaseUpdateUserData,
        super(EditProfileInitial());

  Future editUserData({
    required UserEntity user,
  }) async {
    // emit loading state

    final response =
        await _useCaseUpdateUserData(UseCaseUpdateUserDataParams(UserEntity(
      userId: user.userId,
      fullName: user.fullName,
      dob: user.dob,
      gender: user.gender,
      profilePicUrl: user.profilePicUrl,
      createdAt: user.createdAt,
      email: user.email,
      phoneNo: user.phoneNo,
      password: user.password,
    )));

    response.fold(
      (l) {
        emit(EditProfileStateFailure(l.message));
      },
      (r) {
        emit(EditProfileStateDataUpdated(r));
      },
    );
  }
}