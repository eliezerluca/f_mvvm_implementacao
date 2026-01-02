import 'package:mvvm_implementacao/domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String? name;

  // construtores
  UserModel({
    required this.id,
    required this.email,
    this.name,
  });

  // serializacao e desserializacao: cria um UserModel a partir de um json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['user_metadata']?['name'] ?? json['name'] as String?,
    );
  }

  // converte o UserModel para json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      if (name != null) 'user_metadata': {'name': name},
    };
  }

  // converte de modelo para entidade
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
    );
  }

  // converte de entidade para modelo
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
    );
  }

  @override
  String toString() => 'UserModel(id: $id, email: $email, name: $name)';
}
