import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_implementacao/data/datasources/auth_supabase_data_source.dart';
import 'package:mvvm_implementacao/data/repositories/auth_repository_impl.dart';
import 'package:mvvm_implementacao/domain/repositories/auth_repository.dart';
import 'package:mvvm_implementacao/presentation/viewmodels/login_viewmodel.dart';
import 'package:mvvm_implementacao/presentation/views/login_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  final supabase = Supabase.instance.client;

  final authDataSource = AuthSupabaseDataSource(supabase);

  final AuthRepository authRepository = AuthRepositoryImpl(authDataSource);

  final loginViewModel = LoginViewmodel(authRepository);
  runApp(MyApp(loginViewModel: loginViewModel));
}

class MyApp extends StatelessWidget {
  final LoginViewmodel loginViewModel;

  const MyApp({super.key, required this.loginViewModel});

  @override
  Widget build(BuildContext context) {
    // Build your app's widget tree here, using loginViewModel as needed
    return ChangeNotifierProvider.value(
      value: loginViewModel,
      child: MaterialApp(
        title: 'MVVM + Clean Architecture',
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
