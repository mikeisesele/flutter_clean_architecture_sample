import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_management_system/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:learning_management_system/src/authentication/domain/usecases/create_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser useCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    useCase = CreateUser(repository);
    // registerFallbackValue(value) - used for custom data types
  });

  const params = CreateUserParams.empty();

  test('should call the [AuthRepo.createUser]', () async {
    // Arrange - Given
    // thenAnswer -> for async functions
    // thenReturn -> for non async functions

    // this is stubbing
    when(() => repository.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar")))
        .thenAnswer((invocation) async => const Right(null));

    // Act - When
    final result = await useCase(params);

    // Assert - Then
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
