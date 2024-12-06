import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/features/auth/domain/usecases/get_current_uid.dart';
import 'package:meta/meta.dart';

part 'user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  final UseCaseGetCurrentUid _useCaseGetCurrentUid;

  UserAuthCubit({
    required UseCaseGetCurrentUid useCaseGetCurrentUid,
  })  : _useCaseGetCurrentUid = useCaseGetCurrentUid,
        super(UserAuthInitial());

  Future checkForLogin() async {
    final response = await _useCaseGetCurrentUid(UseCaseGetCurrentUidParams());

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        emit(UserAuthStateResult(r));
      },
    );
  }
}
