import 'package:mvvm_implementacao/data/dtos/login_request_dto.dart';
import 'package:mvvm_implementacao/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabaseDataSource {
  final SupabaseClient _supabase;
  AuthSupabaseDataSource(this._supabase);

  Future<UserModel?> login(LoginRequestDto dto) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: dto.email,
        password: dto.password,
      );

      final user = response.user;

      if (user == null) {
        throw Exception('Usuário não encontrado');
      }

      final userData = {
        'id': user.id,
        'email': user.email,
        'user_metadata': user.userMetadata,
      };

      return UserModel.fromJson(userData);
    } on AuthException catch (e) {
      switch (e.statusCode) {
        case '400':
          throw Exception(
            'Requisição inválida. Verifique os dados fornecidos.',
          );
        case '401':
          throw Exception('Credenciais inválidas. Tente novamente.');
        case '403':
          throw Exception(
            'Acesso negado. Você não tem permissão para acessar este recurso.',
          );
        case '404':
          throw Exception(
            'Usuário não encontrado. Verifique o email fornecido.',
          );
        case '500':
          throw Exception(
            'Erro no servidor. Tente novamente mais tarde.',
          );
        default:
          throw Exception('Erro desconhecido: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erro ao tentar logar: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Erro ao tentar deslogar: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;

      if (user == null) {
        return null;
      }

      final userData = {
        'id': user.id,
        'email': user.email,
        'user_metadata': user.userMetadata,
      };

      return UserModel.fromJson(userData);
    } catch (e) {
      throw Exception('Erro ao obter o usuário atual: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final user = _supabase.auth.currentUser;
      return user != null;
    } catch (e) {
      throw Exception('Erro ao verificar o status de login: $e');
    }
  }
}
