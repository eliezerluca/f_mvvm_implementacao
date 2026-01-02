import 'package:mvvm_implementacao/core/result/app_result.dart';
import 'package:mvvm_implementacao/domain/entities/user.dart';

abstract class AuthRepository {
  Future<AppResult<User>> login({
    required String email,
    required String password,
  });
  Future<AppResult<void>> logout();
  Future<AppResult<User?>> getCurrentUser();
  Future<AppResult<bool>> isLoggedIn();
}
