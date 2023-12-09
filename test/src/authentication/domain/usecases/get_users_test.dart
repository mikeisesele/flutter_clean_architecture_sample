import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_management_system/src/authentication/domain/entities/user.dart';
import 'package:learning_management_system/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:learning_management_system/src/authentication/domain/usecases/get_users_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
    // registerFallbackValue(value) - used for custom data types
  });

  const apiResponse = [User.empty()];

  test('should call [AuthRepo.getUsers] and return [List<User>]', () async {
    // Arrange - Given
    // thenAnswer -> for async functions
    // thenReturn -> for non async functions

    // this is stubbing
    when(() => repository.getUsers())
        .thenAnswer((invocation) async => const Right(apiResponse));

    // Act - When
    final result = await usecase();

    // Assert - Then
    expect(result, equals(const Right<dynamic, List<User>>(apiResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
