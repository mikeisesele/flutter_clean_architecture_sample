import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_management_system/core/errors/exceptions.dart';
import 'package:learning_management_system/core/utilities/typedef.dart';
import 'package:learning_management_system/src/authentication/data/models/user_model.dart';

import '../../../../core/utilities/constants.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/api/v1/users';
const kGetUserEndpoint = '/api/v1/users';

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // check to make sure it returns the right data when the response is 200 or the proper response code
    // check to make sure that it throws a custom exception with the right message when status code is the bad one

    try {
      final response =
          await _client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
              body: jsonEncode({
                'createdAt': createdAt,
                'name': name,
                'avatar': avatar,
              }),
              headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kGetUserEndpoint));
      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
