import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:learning_management_system/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:learning_management_system/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:learning_management_system/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:learning_management_system/src/authentication/domain/usecases/create_user_usecase.dart';
import 'package:learning_management_system/src/authentication/domain/usecases/get_users_usecase.dart';
import 'package:learning_management_system/src/authentication/presentation/cubit/authentication_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator
    // app logic
    ..registerFactory(() => AuthenticationCubit(
        createUser: serviceLocator(), getUsers: serviceLocator()))
    // use-cases
    ..registerLazySingleton(() => CreateUser(serviceLocator()))
    ..registerLazySingleton(() => GetUsers(serviceLocator()))
    //repo
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(serviceLocator()))
    // data source
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(serviceLocator()))
    // external deps
    ..registerLazySingleton(http.Client.new);
}
