import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:learning_management_system/core/errors/exceptions.dart';
import 'package:learning_management_system/core/utilities/constants.dart';
import 'package:learning_management_system/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:learning_management_system/src/authentication/data/models/user_model.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the statusCode is 200 or 201',
        () async {
      when(() => client.post(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((invocation) async =>
              http.Response("User created successfully", 201));

      final methodCall = remoteDataSource.createUser;

      expect(
          methodCall(
            createdAt: "createdAt",
            avatar: "avatar",
            name: "name",
          ),
          completes);

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
              {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'}),
          headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200 or 201',
        () async {
      when(() => client
          .post(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'})).thenAnswer(
          (invocation) async => http.Response("Invalid email address", 400));

      final methodCall = remoteDataSource.createUser;

      expect(
          () async => methodCall(
                createdAt: "createdAt",
                avatar: "avatar",
                name: "name",
              ),
          throwsA(const APIException(
              message: "Invalid email address", statusCode: 400)));

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
              {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'}),
          headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];
    const tMessage = "Server Down";
    test('should return a [List<User>] when the status is 200', () async {
      when(() => client.get(any())).thenAnswer((invocation) async =>
          http.Response(jsonEncode([tUsers.first.toMap()]), 200));

      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));
      verify(() => client.get(Uri.https(kBaseUrl, kGetUserEndpoint))).called(1);
      verifyNoMoreInteractions(client);
    });
    test('should throw [APIException] when status code is not 200', () async {
      when(() => client.get(any()))
          .thenAnswer((invocation) async => http.Response(tMessage, 500));

      final methodCall = remoteDataSource.getUsers;

      expect(() => methodCall(),
          throwsA(const APIException(message: tMessage, statusCode: 500)));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUserEndpoint))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
