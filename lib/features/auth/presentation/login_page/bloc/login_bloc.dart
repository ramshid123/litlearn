import 'package:bloc/bloc.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/features/auth/domain/usecases/login.dart';
import 'package:litlearn/features/auth/domain/usecases/signup.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UseCaseSignup _useCaseSignup;
  final UseCaseLogin _useCaseLogin;

  LoginBloc(
      {required UseCaseLogin useCaseLogin,
      required UseCaseSignup useCaseSignup})
      : _useCaseSignup = useCaseSignup,
        _useCaseLogin = useCaseLogin,
        super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoginEventSignup>(
        (event, emit) async => await _onLoginEventSignup(event, emit));

    on<LoginEventLogin>(
        (event, emit) async => await _onLoginEventLogin(event, emit));
  }

  Future _onLoginEventLogin(
      LoginEventLogin event, Emitter<LoginState> emit) async {
    emit(LoginStateLoading());

    if (event.email.isEmpty || event.password.isEmpty) {
      emit(LoginStateFailure('Please fill all the fields.'));
    } else {
      final response = await _useCaseLogin(
          UseCaseLoginParams(email: event.email, password: event.password));
      response.fold(
        (l) {
          emit(LoginStateFailure('Unable to login. Please try again'));
        },
        (r) {
          if (r == null) {
            emit(LoginStateFailure(
                'Please check your credentials and try again.'));
          } else {
            emit(LoginStateSuccess(r));
          }
        },
      );
    }
  }

  Future _onLoginEventSignup(
      LoginEventSignup event, Emitter<LoginState> emit) async {
    emit(LoginStateLoading());

    if (event.email.isEmpty ||
        event.password.isEmpty ||
        event.fullname.isEmpty) {
      emit(LoginStateFailure('Please fill all fields correctly'));
    } else {
      final response = await _useCaseSignup(UseCaseSignupParams(
        fullname: event.fullname,
        email: event.email,
        password: event.password,
      ));

      response.fold(
        (l) {
          emit(LoginStateFailure('Unable to login. Please try again.'));
        },
        (r) {
          emit(LoginStateSuccess(r));
        },
      );
    }
  }
}
