import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mediplan/blocs/session_bloc/session_cubit.dart';
import 'package:mediplan/repositories/auth_repository.dart';
import 'package:mediplan/views/Navigation/app_navigator.dart';

void main() async {
  // TODO : Pour les futurs developpeurs, creez un fichier .env avec le contenu du fichier .env.example
  await dotenv.load(fileName: ".env");

  runApp(const Mediplan());
}

class Mediplan extends StatelessWidget {
  const Mediplan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => SessionCubit(
            authRepository: context.read<AuthRepository>(),
          ),
          child: const AppNavigator(),
        ),
      ),
    );
  }
}
