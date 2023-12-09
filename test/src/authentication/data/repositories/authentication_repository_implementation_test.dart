import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_management_system/core/errors/exceptions.dart';
import 'package:learning_management_system/core/errors/failure.dart';
import 'package:learning_management_system/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:learning_management_system/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:learning_management_system/src/authentication/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repositoryImplementation;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImplementation =
        AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException =
      APIException(message: "Unknown Error Occurred", statusCode: 500);

  group('createUser', () {
    const createdAt = "Created At";
    const name = "John Doe";
    const avatar = "Avatar";

    test(
        'should call the [RemoteDataSource.createUser] and '
        'complete successfully when the call to the remote source is successful',
        () async {
      // arrange
      when(() => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((invocation) async => Future.value());

      // act
      final result = await repositoryImplementation.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [APIFailure] when the call to the'
        'remote source is unsuccessful', () async {
      when(() => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          )).thenThrow(tException);

      final result = await repositoryImplementation.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(
          result,
          equals(Left(APIFailure(
              message: tException.message,
              statusCode: tException.statusCode))));

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test(
        'should call the [RemoteDataSource.getUsers] and complete successfully when the'
        'call to remote source is successful', () async {
      when(() => remoteDataSource.getUsers())
          .thenAnswer((invocation) async => []);

      final result = await repositoryImplementation.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [APIFailure] when the call to the'
        'remote source is unsuccessful', () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);
      final result = await repositoryImplementation.getUsers();

      expect(result, equals(Left(APIFailure.fromException(tException))));
    });
  });
}
