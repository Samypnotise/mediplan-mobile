import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/components/google_map_modal.dart';
import 'package:mediplan/constants/mediplan_colors.dart';

class PlanningView extends StatefulWidget {
  const PlanningView({super.key});

  @override
  State<PlanningView> createState() => _PlanningViewState();
}

class _PlanningViewState extends State<PlanningView> {
  DateTime _currentDate = DateTime.now();

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
                    "Planning des missions",
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              //! Indication sur l'utilité de la page
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
                      "Visualisez votre organisation du jour.",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: MediplanColors.placeholder,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              //! Sélecteur de date
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _currentDate =
                              _currentDate.subtract(const Duration(days: 1));
                        });
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.solidHandPointLeft,
                        color: MediplanColors.primary,
                        size: 35,
                      ),
                    ),
                    Text(
                      _currentDate.day == DateTime.now().day
                          ? "Aujourd'hui"
                          : DateFormat("dd/MM/yyyy").format(_currentDate),
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _currentDate =
                              _currentDate.add(const Duration(days: 1));
                        });
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.solidHandPointRight,
                        color: MediplanColors.primary,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              //! Bouton permettant de montrer l'itinéraire sur la carte, dans une BottomSheet
              if (_currentDate.day == DateTime.now().day)
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO : Display the bottom sheet to show the google map
                      showGoogleMapModal(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MediplanColors.secondary,
                      elevation: 5,
                      shadowColor: MediplanColors.quaternary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.white,
                          size: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Afficher l'itinéraire",
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
