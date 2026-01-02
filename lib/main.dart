import 'package:mvvm_implementacao/core/result/app_result.dart';

void main() {
  AppResult<String> success = AppResult.success('Funcionou!');

  print('Sucesso? ${success.isSuccess},\n Dados: ${success.data}');

  AppResult<String> failure = AppResult.failure('Deu erro!');
  print('Falha? ${failure.isFailure},\n Erro: ${failure.error}');
}
