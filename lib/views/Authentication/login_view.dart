import 'package:mediplan/components/custom_flushbar.dart';
import 'package:mediplan/components/input_widget.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/constants/flushbar_type.dart';
import 'package:mediplan/blocs/login_bloc/login_bloc.dart';
import 'package:mediplan/blocs/login_bloc/login_event.dart';
import 'package:mediplan/blocs/login_bloc/login_state.dart';
import 'package:mediplan/blocs/auth_bloc/auth_cubit.dart';
import 'package:mediplan/repositories/auth_repository.dart';
import 'package:mediplan/status/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
        authCubit: context.read<AuthCubit>(),
      ),
      child: _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Connexion',
            style: TextStyle(
              fontFamily: GoogleFonts.oleoScript().fontFamily,
              fontSize: 50,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
                  //! Login image
                  SvgPicture.asset(
                    'lib/images/Tablet-login-amico.svg',
                    width: 250,
                  ),
                  const Spacer(),
                  //! Login form
                  LoginForm(formKey: _formKey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrSeparator extends StatelessWidget {
  const OrSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Divider(
            color: MediplanColors.placeholder, // Line color
            thickness: 2, // Line thickness
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "OU",
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: MediplanColors.placeholder),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey, // Line color
            thickness: 2, // Line thickness
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;

        if (formStatus is SubmissionFailed) {
          showCustomFlushbar(
            context,
            'Erreur lors de la connexion',
            'Veuillez vérifier votre email et/ou votre mot de passe.',
            const FaIcon(
              FontAwesomeIcons.solidFaceDizzy,
              color: Colors.white,
              size: 30,
            ),
            FlushbarType.danger,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //! Email input
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: EmailInput(),
            ),
            //! Password input
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: PasswordInput(),
            ),
            //! Login button
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state.formStatus is FormSubmittting
                      ? const SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator(
                            color: MediplanColors.primary,
                            strokeCap: StrokeCap.round,
                            strokeWidth: 6,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () => {
                                if (state.isValidEmail && state.isValidPassword)
                                  {
                                    context
                                        .read<LoginBloc>()
                                        .add(LoginSubmitted())
                                  }
                                else
                                  {
                                    showCustomFlushbar(
                                      context,
                                      'Ouuups ...',
                                      'Vous devez fournir votre email et votre mot de passe.',
                                      const FaIcon(
                                        FontAwesomeIcons.solidFaceFrownOpen,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      FlushbarType.warning,
                                    )
                                  }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MediplanColors.primary,
                                elevation: 5,
                                shadowColor: MediplanColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Se connecter !",
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: MediplanColors.background,
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Input(
        isError: !state.isValidEmail,
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginEmailChanged(email: value),
            ),
        placeholder: "john.doe@gmail.com",
        prefixIcon: const FaIcon(
          FontAwesomeIcons.solidEnvelope,
          color: MediplanColors.primary,
        ),
      );
    });
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Input(
          isError: !state.isValidPassword,
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
          prefixIcon: const FaIcon(
            FontAwesomeIcons.lock,
            color: MediplanColors.primary,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: TextButton(
              child: Text(
                "C'est oublié ?",
                style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.bold,
                  color: MediplanColors.primary,
                ),
              ),
              onPressed: () {
                context.read<AuthCubit>().showForgottenPasswordView();
              },
            ),
          ),
          placeholder: "●●●●●●●●●●",
          isPassword: true,
        );
      },
    );
  }
}
