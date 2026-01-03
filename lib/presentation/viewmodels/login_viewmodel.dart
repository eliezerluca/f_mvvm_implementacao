import 'package:flutter/material.dart';
import 'package:mvvm_implementacao/domain/entities/user.dart';
import 'package:mvvm_implementacao/domain/repositories/auth_repository.dart';

class LoginViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewmodel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  User? _user;
  User? get user => _user;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Preencha todos os campos.';
      notifyListeners();
      return;
    }

    // Inicia o processo de login, ativa loading e limpa erros anteriores
    reset();
    _isLoading = true;
    notifyListeners();

    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    _isLoading = false;

    if (result.isSuccess && result.data != null) {
      _user = result.data;
      _isSuccess = true;
      clearError();

      debugPrint('Login bem-sucedido: ${_user.toString()}');
    } else {
      _errorMessage = result.error ?? 'Erro desconhecido durante o login.';
      // _isSuccess = false;
      // _user = null;

      debugPrint('Falha no login: $_errorMessage');
    }
    notifyListeners();
  }

  Future<void> logout() async {
    reset();
    _isLoading = true;
    notifyListeners();

    final result = await _authRepository.logout();

    _isLoading = false;

    // if (result.isSuccess) {
    //   _user = null;
    //   _isSuccess = true;
    //   clearError() ;

    //   debugPrint('Logout bem-sucedido');
    // } else {
    //   _errorMessage = result.error ?? 'Erro desconhecido durante o logout.';
    //   _isSuccess = false;

    //   debugPrint('Falha no logout: $_errorMessage');
    // }

    if (result.isFailure) {
      _errorMessage = result.error ?? 'Erro desconhecido durante o logout.';
      // _isSuccess = false;

      debugPrint('Falha no logout: $_errorMessage');
    } else {
      // _user = null;
      // _isSuccess = true;
      clearError();

      debugPrint('Logout bem-sucedido');
    }
    notifyListeners();
  }

  Future<void> checkCurrentUser() async {
    reset();
    _isLoading = true;
    notifyListeners();

    final result = await _authRepository.getCurrentUser();

    _isLoading = false;

    if (result.isSuccess) {
      _user = result.data;
      _isSuccess = _user != null;
      clearError();

      debugPrint('Usuário atual obtido com sucesso: ${_user.toString()}');
    } else {
      _errorMessage =
          result.error ?? 'Erro desconhecido ao obter o usuário atual.';
      _isSuccess = false;
      _user = null;

      debugPrint('Falha ao obter o usuário atual: $_errorMessage');
    }
    notifyListeners();
  }

  @override
  /// Dispose: Limpa os recursos alocados pelo ViewModel.
  void dispose() {
    // Exemplo de stream ou controllers que poderiam ser fechados aqui:
    // _someStreamController?.close();
    // _anotherResource?.dispose();
    super.dispose();
  }

  ///Function clearError: Limpa a mensagem de erro atual e notifica os ouvintes.
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Function reset: Restaura o estado do ViewModel para os valores iniciais e notifica os ouvintes.
  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _user = null;
    _isSuccess = false;
    notifyListeners();
  }

  /// Function clearSuccess: Limpa o estado de sucesso atual e notifica os ouvintes.
  void clearSuccess() {
    _isSuccess = false;
    notifyListeners();
  }
}
