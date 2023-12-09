import 'package:dartz/dartz.dart';
import 'package:learning_management_system/core/errors/exceptions.dart';
import 'package:learning_management_system/core/errors/failure.dart';
import 'package:learning_management_system/core/utilities/typedef.dart';
import 'package:learning_management_system/src/authentication/domain/entities/user.dart';
import 'package:learning_management_system/src/authentication/domain/repositories/authentication_repository.dart';

import '../datasources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // TDD

    // call the remote data source
    // check if the method returns proper data
    // make sure it returns the proper data if no exception
    //  // check if  when the remote data source throws an exception, return a failure
    //  // check if  when the remote data source does not throw an exception, return a data

    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
