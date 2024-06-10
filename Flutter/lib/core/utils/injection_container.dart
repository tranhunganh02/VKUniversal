import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vkuniversal/features/auth/data/data_sources/local/class_local_service.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:vkuniversal/features/auth/data/models/user.dart';
import 'package:vkuniversal/features/auth/data/repository/auth_repository_impl.dart';
import 'package:vkuniversal/features/auth/data/repository/user_info_reposirory_impl.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';
import 'package:vkuniversal/features/auth/domain/repository/user_info_repository.dart';
import 'package:vkuniversal/features/auth/domain/usecases/check_student_info.dart';
import 'package:vkuniversal/features/auth/domain/usecases/logout.dart';
import 'package:vkuniversal/features/auth/domain/usecases/refresh_token.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:vkuniversal/features/auth/domain/usecases/update_student_info.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/add_user_info/bloc/add_user_info_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_in/bloc/sign_in_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';
import 'package:vkuniversal/features/newsfeed/data/datasourse/remote/post_api_service.dart';
import 'package:vkuniversal/features/newsfeed/data/repository/post_repository_impl.dart';
import 'package:vkuniversal/features/newsfeed/domain/repository/post_repository.dart';
import 'package:vkuniversal/features/newsfeed/domain/usecase/get_posts.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/home/bloc/home_bloc.dart';
import 'package:vkuniversal/features/newsfeed/presentation/state/newfeeds/bloc/newfeed_bloc.dart';
import 'package:vkuniversal/features/profile/data/data_sourse/remote/profile_api_service.dart';
import 'package:vkuniversal/features/profile/data/model/profile.dart';
import 'package:vkuniversal/features/profile/data/repository/profile_repository_impl.dart';
import 'package:vkuniversal/features/profile/domain/repository/profile_repository.dart';
import 'package:vkuniversal/features/profile/domain/usecase/load_profile.dart';
import 'package:vkuniversal/features/profile/presentation/state/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(
      Dio(BaseOptions(connectTimeout: Duration(milliseconds: 5000))));
  // // Dependencies

  sl.registerFactory<AuthApiService>(() => AuthApiService(sl()));
  sl.registerFactory<UserApiService>(() => UserApiService(sl()));
  sl.registerFactory<ProfileApiService>(() => ProfileApiService(sl()));
  sl.registerFactory<ClassLocalService>(() => ClassLocalService());
  sl.registerFactory<PostApiService>(() => PostApiService(sl()));

  sl.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authApiService: sl()));
  sl.registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(profileApiService: sl()));
  sl.registerFactory<UserInfoRepository>(
      () => UserInfoReposiroryImpl(sl(), classLocalService: sl()));
  sl.registerFactory<PostRepository>(
      () => PostRepositoryImpl(postApiService: sl()));

  sl.registerFactory<SignUpWithEmail>(() => SignUpWithEmail(sl()));
  sl.registerFactory<RefreshToken>(() => RefreshToken(authRepository: sl()));
  sl.registerFactory<CheckUserInfoExists>(
      () => CheckUserInfoExists(authRepository: sl()));
  sl.registerFactory<SignInWithEmail>(
      () => SignInWithEmail(authRepository: sl()));
  sl.registerFactory<UpdateStudentInfo>(
      () => UpdateStudentInfo(infoReposirory: sl()));
  sl.registerFactory<LoadProfileUseCase>(
      () => LoadProfileUseCase(profileRepository: sl()));
  sl.registerFactory<Logout>(() => Logout(authRepository: sl()));
  sl.registerSingleton<GetPosts>(GetPosts(postRepository: sl()));

  sl.registerFactory<SignUpBloc>(() => SignUpBloc(sl()));
  sl.registerFactory<SignInBloc>(() => SignInBloc(sl()));
  sl.registerSingleton<ProfileBloc>(ProfileBloc(sl()));
  sl.registerSingleton<WelcomeBloc>(WelcomeBloc());
  sl.registerSingleton<NewfeedBloc>(NewfeedBloc(sl()));

  sl.registerSingleton<BottomNavigationBloc>(BottomNavigationBloc());
  sl.registerSingleton<AddUserInfoBloc>(AddUserInfoBloc(sl(), sl()));

  sl.registerFactory<UserModel>(() => UserModel(
      uid: null,
      email: '',
      displayName: '',
      role: null,
      phoneNumber: '',
      createdAt: '',
      lastLoginAt: '',
      avatar: ''));
  sl.registerFactory<ProfileModel>(() => ProfileModel(userBio: '', user: sl()));
}
