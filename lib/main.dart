import 'package:flutter/material.dart';
import 'package:mvvm_implementacao/data/models/user_model.dart';
import 'package:mvvm_implementacao/domain/entities/user.dart';

void main() {
  // simulando um json da api
  Map<String, dynamic> json = {
    'id': '123',
    'email': 'joao@teste.com',
    'user_metadata': {'name': 'joao silva'},
  };

  // json -> model
  UserModel model = UserModel.fromJson(json);
  debugPrint('Model: $model');

  // model -> entity
  User entity = model.toEntity();
  debugPrint('Entity: $entity');

  // entity -> model
  UserModel modelFromEntity = UserModel.fromEntity(entity);
  debugPrint('Model from Entity: $modelFromEntity');

  // model -> json
  debugPrint('JSON: ${modelFromEntity.toJson()}');
}
