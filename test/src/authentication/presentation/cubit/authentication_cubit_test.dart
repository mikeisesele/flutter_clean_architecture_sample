import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_management_system/core/errors/failure.dart';
import 'package:learning_management_system/src/authentication/domain/usecases/create_user_usecase.dart';
import 'package:learning_management_system/src/authentication/domain/usecases/get_users_usecase.dart';
import 'package:learning_management_system/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = APIFailure(message: 'message', statusCode: 400);

  setUp(() => {
        getUsers = MockGetUsers(),
        createUser = MockCreateUser(),
        cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers),
        registerFallbackValue(tCreateUserParams)
      });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial', () async {
    expect(cubit.state, equals(const AuthenticationInitial()));
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [CreatingUser, UserCreated] when successful',
        build: () {
          when(() => createUser(any())).thenAnswer(
            (invocation) async => const Right(null),
          );
          return cubit;
        },
        act: (cubit) => cubit.createUser(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        // act: (bloc) => bloc.add(CreateUserEvent(createdAt: createdAt, name: name, avatar: avatar))

        expect: () => const [CreatingUser(), UserCreated()],
        verify: (_) {
          verify(() => createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });
  });

  blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, AuthenticationError] when unsuccessful',
      build: () {
        // stub
        when(() => createUser(any()))
            .thenAnswer((invocation) async => const Left(tAPIFailure));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
          createdAt: tCreateUserParams.createdAt,
          name: tCreateUserParams.name,
          avatar: tCreateUserParams.avatar),
      expect: () => [
            const CreatingUser(),
            AuthenticationError(tAPIFailure.errorMessage),
          ],
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      });
}
