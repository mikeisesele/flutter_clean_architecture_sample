// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:learning_management_system/src/authentication/domain/usecases/get_users_usecase.dart';
//
// import '../../domain/entities/user.dart';
// import '../../domain/usecases/create_user_usecase.dart';
//
// part 'authentication_event.dart';
// part 'authentication_state.dart';
//
// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   AuthenticationBloc({
//     required CreateUser createUser,
//     required GetUsers getUsers,
//   })  : _createUser = createUser,
//         _getUsers = getUsers,
//         super(const AuthenticationInitial()) {
//     on<CreateUserEvent>((_createUserHandler));
//     on<GetUsersEvent>((_getUserHandler));
//   }
//
//   final CreateUser _createUser;
//   final GetUsers _getUsers;
//
//   Future<void> _createUserHandler(
//     CreateUserEvent event,
//     Emitter<AuthenticationState> emit,
//   ) async {
//     emit(const CreatingUser());
//
//     final result = await _createUser(CreateUserParams(
//         createdAt: event.createdAt, name: event.name, avatar: event.avatar));
//
//     result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
//         (success) => emit(const UserCreated()));
//   }
//
//   Future<void> _getUserHandler(
//     GetUsersEvent event,
//     Emitter<AuthenticationState> emit,
//   ) async {
//     emit(const GettingUsers());
//
//     final result = await _getUsers();
//
//     result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
//         (users) => emit(UsersLoaded(users)));
//   }
// }
