class LoginRequestDto {
  final String email;
  final String password;

  LoginRequestDto({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Criar DTO a partir de um JSON
  factory LoginRequestDto.fromJson(Map<String, dynamic> json) {
    return LoginRequestDto(
      email: json['email'],
      password: json['password'],
    );
  }

  // Validação básica de dados
  String? validate() {
    if (email.isEmpty || !email.contains('@')) {
      return 'Email inválido';
    }
    if (password.isEmpty || password.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null; // Dados válidos
  }

  @override
  String toString() => 'LoginRequestDto(email: $email, password: ****)';
}
