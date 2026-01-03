import 'package:flutter/material.dart';
import 'package:mvvm_implementacao/data/datasources/auth_supabase_data_source.dart';
import 'package:mvvm_implementacao/data/repositories/auth_repository_impl.dart';
import 'package:mvvm_implementacao/presentation/viewmodels/login_viewmodel.dart';
import 'package:mvvm_implementacao/presentation/views/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final dataSource = AuthSupabaseDataSource();
        final authRepo = AuthRepositoryImpl(dataSource);
        return LoginViewmodel(authRepo);
      },
      child: MaterialApp(
        title: 'MVVM App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
