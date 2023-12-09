import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learning_management_system/core/utilities/typedef.dart';
import 'package:learning_management_system/src/authentication/data/models/user_model.dart';
import 'package:learning_management_system/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be a subClass of [User] entity', () {
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [userModel] with the right data', () {
      final results = UserModel.fromMap(tMap);
      expect(results, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [userModel] with the right data', () {
      final results = UserModel.fromJson(tJson);
      expect(results, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      final results = tModel.toMap();
      expect(results, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [Json String] with the right data', () {
      final results = tModel.toJson();
      final tJson = jsonEncode({
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "id": "1"
      });
      expect(results, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      final result = tModel.copyWith(name: "Paul");
      expect(result.name, equals("Paul"));
    });
  });
}
