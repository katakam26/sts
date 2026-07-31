import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sts/services/auth_wrapper.dart';
import 'package:sts/utils/app_colors.dart';
import 'package:sts/services/api_services.dart';
import 'package:sts/utils/secure_storage.dart';

import 'feature/login/bloc/login_bloc.dart';
import 'feature/login/repository/login_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginRepository(ApiService()),
        ),
        RepositoryProvider(
          create: (context) => SecureStorageService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              loginRepository: context.read<LoginRepository>(),
              secureStorageService: context.read<SecureStorageService>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'STS App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const AuthWrapper(),
        ),
      ),
    );
  }
}