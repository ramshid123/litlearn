import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/features/auth/data/data%20source/auth_data_service.dart';
import 'package:litlearn/features/auth/data/data%20source/auth_data_source.dart';
import 'package:litlearn/features/auth/data/repository/auth_repository.dart';
import 'package:litlearn/features/auth/domain/repository/auth_repository.dart';
import 'package:litlearn/features/auth/domain/usecases/check_email_verified.dart';
import 'package:litlearn/features/auth/domain/usecases/get_current_uid.dart';
import 'package:litlearn/features/auth/domain/usecases/login.dart';
import 'package:litlearn/features/auth/domain/usecases/logout.dart';
import 'package:litlearn/features/auth/domain/usecases/send_reset_pass_email.dart';
import 'package:litlearn/features/auth/domain/usecases/send_verification_email.dart';
import 'package:litlearn/features/auth/domain/usecases/signup.dart';
import 'package:litlearn/features/auth/domain/usecases/update_user_data.dart';
import 'package:litlearn/features/auth/presentation/edit_profile_page/cubit/edit_profile_cubit.dart';
import 'package:litlearn/features/auth/presentation/email_verification_page/cubit/email_verification_cubit.dart';
import 'package:litlearn/features/auth/presentation/login_page/bloc/login_bloc.dart';
import 'package:litlearn/features/auth/presentation/settings_page/cubit/settings_cubit.dart';
import 'package:litlearn/features/auth/presentation/splash_screen/cubit/user_auth_cubit.dart';
import 'package:litlearn/features/learning/data/data%20source/remote_datasource.dart';
import 'package:litlearn/features/learning/data/repository/remote_repository.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';
import 'package:litlearn/features/learning/domain/usecases/enroll_course.dart';
import 'package:litlearn/features/learning/domain/usecases/get_categories.dart';
import 'package:litlearn/features/learning/domain/usecases/get_course_by_id.dart';
import 'package:litlearn/features/learning/domain/usecases/get_courses.dart';
import 'package:litlearn/features/learning/domain/usecases/get_enrolled_course.dart';
import 'package:litlearn/features/learning/domain/usecases/get_enrolled_courses_list.dart';
import 'package:litlearn/features/learning/domain/usecases/get_video_by_id.dart';
import 'package:litlearn/features/learning/domain/usecases/update_enrolled_course_seqcount.dart';
import 'package:litlearn/features/learning/presentation/course_page/bloc/course_page_bloc.dart';
import 'package:litlearn/features/learning/presentation/course_page/cubit/enrolled_course_cubit.dart';
import 'package:litlearn/features/learning/presentation/course_page/cubit/videos_cubit.dart';
import 'package:litlearn/features/learning/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:litlearn/features/learning/presentation/home_page/cubit/categories_cubit.dart';
import 'package:litlearn/features/learning/presentation/my_courses_page/bloc/my_courses_bloc.dart';
import 'package:litlearn/features/learning/presentation/video_player_page/cubit/video_player_cubit.dart';
import 'package:litlearn/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseFirestore firebaseDb = FirebaseFirestore.instance;
  final SharedPreferences sharedPreferencesInstance =
      await SharedPreferences.getInstance();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  serviceLocator
    ..registerLazySingleton(() => firebaseDb)
    ..registerLazySingleton(() => sharedPreferencesInstance)
    ..registerLazySingleton(() => firebaseAuth);

  _initLearning();

  firebaseAuth.userChanges().listen((user) {
    if (user == null) {
    } else {}
  });
}

void _initLearning() {
  serviceLocator
    ..registerFactory<LearningRemoteDataSource>(
        () => LearningRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<LearningRemoteRepository>(
        () => LearningRemoteRepositoryImpl(serviceLocator()))
    ..registerFactory<AuthService>(() => AuthServiceImpl(serviceLocator()))
    ..registerFactory<AuthDataSource>(
        () => AuthDataSourceImpl(serviceLocator()))
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        authService: serviceLocator(), authDataSource: serviceLocator()))
    ..registerFactory(() => UseCaseGetCourses(serviceLocator()))
    ..registerFactory(() => UseCaseGetCourseById(serviceLocator()))
    ..registerFactory(() => UseCaseGetVideoById(serviceLocator()))
    ..registerFactory(() => UseCaseGetEnrolledCourse(serviceLocator()))
    ..registerFactory(() => UseCaseEnrollCourse(serviceLocator()))
    ..registerFactory(() => UseCaseGetCategories(serviceLocator()))
    ..registerFactory(() => UseCaseSendVerificationEmail(serviceLocator()))
    ..registerFactory(() => UseCaseGetCurrentUid(serviceLocator()))
    ..registerFactory(() => UseCaseGetEnrolledCoursesList(serviceLocator()))
    ..registerFactory(() => UseCaseCheckEmailVerified(serviceLocator()))
    ..registerFactory(() => UseCaseUpdateUserData(serviceLocator()))
    ..registerFactory(() => UseCaseResetPasswordEmail(serviceLocator()))
    ..registerFactory(() => UseCaseLogin(serviceLocator()))
    ..registerFactory(
        () => UseCaseUpdateEnrolledVideoSeqCount(serviceLocator()))
    ..registerFactory(() => UseCaseLogout(serviceLocator()))
    ..registerFactory(() => UseCaseSignup(serviceLocator()))
    ..registerLazySingleton<HomePageBloc>(() => HomePageBloc(
          useCaseGetCourses: serviceLocator(),
        ))
    ..registerLazySingleton(() => CoursePageBloc(
          useCaseGetCourseById: serviceLocator(),
        ))
    ..registerLazySingleton(
        () => VideosCubit(useCaseGetVideoById: serviceLocator()))
    ..registerLazySingleton(() => EnrolledCourseCubit(
          useCaseGetEnrolledCourse: serviceLocator(),
          useCaseEnrollCourse: serviceLocator(),
        ))
    ..registerLazySingleton(() => VideoPlayerCubit(
        useCaseGetVideoById: serviceLocator(),
        useCaseUpdateEnrolledVideoSeqCount: serviceLocator()))
    ..registerLazySingleton(() => LoginBloc(
          useCaseLogin: serviceLocator(),
          useCaseSignup: serviceLocator(),
          useCaseResetPasswordEmail: serviceLocator(),
        ))
    ..registerLazySingleton(() => UserBloc())
    ..registerLazySingleton(
        () => UserAuthCubit(useCaseGetCurrentUid: serviceLocator()))
    ..registerLazySingleton(
        () => SettingsCubit(useCaseLogout: serviceLocator()))
    ..registerLazySingleton(
        () => EditProfileCubit(useCaseUpdateUserData: serviceLocator()))
    ..registerLazySingleton(
        () => MyCoursesBloc(useCaseGetEnrolledCoursesList: serviceLocator()))
    ..registerLazySingleton(
        () => CategoriesCubit(useCaseGetCategories: serviceLocator()))
    ..registerLazySingleton(() => EmailVerificationCubit(
          useCaseCheckEmailVerified: serviceLocator(),
          useCaseSendVerificationEmail: serviceLocator(),
          useCaseLogout: serviceLocator(),
        ));
}
