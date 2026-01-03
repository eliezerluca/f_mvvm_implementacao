import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mvvm_implementacao/presentation/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context, LoginViewmodel viewModel) {
    viewModel.clearError();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    viewModel.login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewmodel>(
      builder: (context, viewModel, child) {
        if (viewModel.isSuccess && viewModel.user != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator //
                .of(context)
                .pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => _SuccessPage(user: viewModel.user!),
                  ),
                );
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Bem-vindo de volta!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Por favor, faça login para continuar.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        hintText: 'Digite seu email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      enabled: !viewModel.isLoading,
                      onChanged: (_) {
                        if (viewModel.errorMessage != null) {
                          viewModel.clearError();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                        hintText: 'Digite sua senha',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      enabled: !viewModel.isLoading,
                      onChanged: (_) {
                        if (viewModel.errorMessage != null) {
                          viewModel.clearError();
                        }
                      },
                      onFieldSubmitted: (_) {
                        if (!viewModel.isLoading) {
                          _handleLogin(context, viewModel);
                        }
                      },
                    ),
                    const SizedBox(height: 24),

                    if (viewModel.errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red.shade700,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                viewModel.errorMessage!,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (viewModel.errorMessage != null)
                      const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: viewModel.isLoading
                          ? null // Desabilita enquanto carrega
                          : () => _handleLogin(context, viewModel),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: viewModel.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(
                              'Entrar',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                    const SizedBox(height: 24),

                    // Link para instruções
                    TextButton(
                      onPressed: () {
                        _showInstructionsDialog(context);
                      },
                      child: const Text('Como configurar o Supabase?'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void _showInstructionsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Configuração do Supabase'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('1. Crie uma conta em supabase.com'),
            SizedBox(height: 8),
            Text('2. Crie um novo projeto'),
            SizedBox(height: 8),
            Text('3. Vá em Authentication > Providers'),
            SizedBox(height: 8),
            Text('4. Habilite Email provider'),
            SizedBox(height: 8),
            Text('5. Copie URL e ANON KEY do projeto'),
            SizedBox(height: 8),
            Text('6. Cole no arquivo main.dart'),
            SizedBox(height: 8),
            Text('7. Crie um usuário em Authentication > Users'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Entendi'),
        ),
      ],
    ),
  );
}

class _SuccessPage extends StatelessWidget {
  final dynamic user;

  const _SuccessPage({required this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login realizado'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Login realizado com sucesso',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Usuário: ${user['name']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Fazer Logout')),
          ],
        ),
      ),
    );
  }
}
