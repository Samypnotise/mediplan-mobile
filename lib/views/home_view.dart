import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediplan/blocs/navigation_bloc/navigation_cubit.dart';
import 'package:mediplan/constants/mediplan_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 30,
            right: 30,
            bottom: 20,
          ),
          child: Column(
            children: [
              //! Titre de la vue
              Row(
                children: [
                  Text(
                    "Tableau de bord",
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              //! Indication sur l'utilité de la vue
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidCircleQuestion,
                    color: MediplanColors.placeholder,
                    size: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Un récapitulatif rapide de vos missions.",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: MediplanColors.placeholder,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              //! Nombre de missions de la journée dans une tile
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: MediplanColors.quaternary,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      splashColor: MediplanColors.quaternary,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        context.read<NavigationCubit>().showPlanningView();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nombre de missions aujourd'hui",
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "5", // TODO : Inclure le nombre de missions à partir du state Mediplan
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: MediplanColors.secondary,
                              ),
                            ),
                            Text(
                              "Cliquez pour y accéder",
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                color: MediplanColors.placeholder,
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //! Prochaine missions dans : (nombre d'heures et minutes)

              //! Demandes de changements de missions reçues
            ],
          ),
        ),
      ),
    );
  }
}
