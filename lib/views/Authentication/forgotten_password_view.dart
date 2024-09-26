import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/blocs/auth_bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgottenPasswordView extends StatefulWidget {
  const ForgottenPasswordView({super.key});

  @override
  State<ForgottenPasswordView> createState() => _ForgottenPasswordViewState();
}

class _ForgottenPasswordViewState extends State<ForgottenPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: FaIcon(FontAwesomeIcons.solidHandPointLeft),
          ),
          onPressed: () {
            context.read<AuthCubit>().showLoginView();
          },
        ),
        iconTheme: const IconThemeData(
          size: 40,
          color: MediplanColors.primary,
        ),
        title: Text(
          'Mot de passe oublié',
          style: TextStyle(
            fontFamily: GoogleFonts.oleoScript().fontFamily,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Column(
                children: [
                  //! Register image
                  SvgPicture.asset(
                    'lib/images/Sign up-amico.svg',
                    width: 250,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
