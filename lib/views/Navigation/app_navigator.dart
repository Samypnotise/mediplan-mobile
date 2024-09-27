import 'package:mediplan/blocs/mediplan_bloc/mediplan_cubit.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/blocs/auth_bloc/auth_cubit.dart';
import 'package:mediplan/repositories/mediplan_repository.dart';
import 'package:mediplan/views/Authentication/auth_navigator.dart';
import 'package:mediplan/repositories/auth_repository.dart';
import 'package:mediplan/views/loading_view.dart';
import 'package:mediplan/blocs/session_bloc/session_cubit.dart';
import 'package:mediplan/blocs/session_bloc/session_state.dart';
import 'package:mediplan/views/Navigation/navigation_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is UnknownSessionState)
            const MaterialPage(child: LoadingView()),
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) => AuthCubit(
                  authRepository: context.read<AuthRepository>(),
                  sessionCubit: context.read<SessionCubit>(),
                ),
                child: const AuthNavigator(),
              ),
            ),
          if (state is Authenticated)
            MaterialPage(
                child: RepositoryProvider(
              create: (context) => MediplanRepository(),
              child: BlocProvider(
                create: (context) => MediplanCubit(
                  mediplanRepository: context.read<MediplanRepository>(),
                ),
                child: BlocBuilder<MediplanCubit, MediplanState>(
                  builder: (context, state) {
                    return const NavigationBarView();
                  },
                ),
              ),
            )),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
