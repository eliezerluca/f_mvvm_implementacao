import 'package:mvvm_implementacao/core/result/app_result.dart';
import 'package:mvvm_implementacao/data/datasources/auth_supabase_data_source.dart';
import 'package:mvvm_implementacao/data/dtos/login_request_dto.dart';
import 'package:mvvm_implementacao/domain/entities/user.dart';
import 'package:mvvm_implementacao/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // Future<User> login({required String email, required String password});
  // Future<void> logout();
  // Future<bool> isLoggedIn();
  // Future<User?> getCurrentUser();
  final AuthSupabaseDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<AppResult<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final dto = LoginRequestDto(email: email, password: password);
      final validationError = dto.validate();

      if (validationError != null) return AppResult.failure(validationError);

      final userModel = await _dataSource.login(dto);

      final userEntity = userModel?.toEntity();

      if (userEntity == null) {
        return AppResult.failure('Erro ao converter usuário.');
      }

      return AppResult.success(userEntity);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  @override
  Future<AppResult<void>> logout() async {
    try {
      await _dataSource.logout();
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  @override
  Future<AppResult<User?>> getCurrentUser() async {
    try {
      final userModel = await _dataSource.getCurrentUser();

      if (userModel == null) {
        return AppResult.success(null);
      }

      final userEntity = userModel.toEntity();
      return AppResult.success(userEntity);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  @override
  Future<AppResult<bool>> isLoggedIn() async {
    try {
      final userModel = await _dataSource.getCurrentUser();
      return AppResult.success(userModel != null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }
}
