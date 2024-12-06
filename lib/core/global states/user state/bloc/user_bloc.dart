import 'package:bloc/bloc.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<UserEventUserUpdate>((event, emit) {
      emit(UserStateUserEntity(event.userEntity));
    });
  }
}
