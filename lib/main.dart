import 'package:mvvm_implementacao/domain/entities/user.dart';

void main() {
  User user = User(
    id: '1',
    email: 'teste@teste.com',
    name: 'Teste',
  );

  print(user);

  User updatedUser = user.copyWith(name: 'Novo Nome', id: '2');
  print('updated user: ${updatedUser}.');

  print('user == updatedUser ? ${user == updatedUser}'); // false, different ids
}
