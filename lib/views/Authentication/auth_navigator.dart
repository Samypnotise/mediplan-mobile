import 'package:mediplan/views/Authentication/forgotten_password_view.dart';
import 'package:mediplan/views/Authentication/login_view.dart';
import 'package:mediplan/blocs/auth_bloc/auth_cubit.dart';
import 'package:mediplan/blocs/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is Login) const MaterialPage(child: LoginView()),
            if (state is ForgottenPassword)
              const MaterialPage(child: ForgottenPasswordView()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
