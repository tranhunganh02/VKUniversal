import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/repository/auth_repository_impl.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_in/bloc/sign_in_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/welcome/bloc/welcome_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(
      Dio(BaseOptions(connectTimeout: Duration(milliseconds: 5000))));
  // Dependencies

  sl.registerFactory<AuthApiService>(() => AuthApiService(sl()));

  sl.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authApiService: sl()));

  sl.registerFactory<SignUpWithEmail>(() => SignUpWithEmail(sl()));
  sl.registerFactory<SignInWithEmail>(
      () => SignInWithEmail(authRepository: sl()));

  sl.registerFactory<SignUpBloc>(() => SignUpBloc(sl()));
  sl.registerFactory<SignInBloc>(() => SignInBloc(sl()));
  sl.registerFactory<WelcomeBloc>(() => WelcomeBloc());
}
