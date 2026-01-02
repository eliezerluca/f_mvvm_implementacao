import 'package:flutter/material.dart';
import 'package:mvvm_implementacao/data/dtos/login_request_dto.dart';

void main() {
  LoginRequestDto validDTO = LoginRequestDto(
    email: 'teste.teste.com',
    password: '123456',
  );

  final validation = validDTO.validate();
  if (validation == null) {
    debugPrint('DTO válido');
  } else {
    debugPrint('DTO inválido: $validation');
  }
}
