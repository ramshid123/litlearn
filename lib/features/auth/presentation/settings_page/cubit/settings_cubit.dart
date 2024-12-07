import 'package:bloc/bloc.dart';
import 'package:litlearn/features/auth/domain/usecases/logout.dart';
import 'package:meta/meta.dart';

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
