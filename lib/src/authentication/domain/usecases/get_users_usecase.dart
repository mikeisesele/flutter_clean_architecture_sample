import 'package:learning_management_system/core/usecase/usecase.dart';
import 'package:learning_management_system/core/utilities/typedef.dart';
import 'package:learning_management_system/src/authentication/domain/entities/user.dart';
import 'package:learning_management_system/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
