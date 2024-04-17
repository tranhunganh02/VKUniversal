import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vkuniversal/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:vkuniversal/features/auth/data/repository/auth_repository_impl.dart';
import 'package:vkuniversal/features/auth/domain/repository/auth_repository.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:vkuniversal/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/auth_bloc.dart';

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

  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
}
