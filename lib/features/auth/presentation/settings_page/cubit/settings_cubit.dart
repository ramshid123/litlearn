import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlearn/features/auth/domain/usecases/logout.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final UseCaseLogout _useCaseLogout;

  SettingsCubit({required UseCaseLogout useCaseLogout})
      : _useCaseLogout = useCaseLogout,
        super(SettingsInitial());

  Future logout() async {
    final response = await _useCaseLogout(UseCaseLogoutParams());

    response.fold(
      (l) {
        emit(SettingsStateFailure(l.message));
      },
      (r) {
        emit(SettingsStateLogoutSuccess());
      },
    );
  }
}
