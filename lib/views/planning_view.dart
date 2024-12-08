import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_bloc.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/components/mission_tile.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission.dart';

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

              //! Liste des missions
              BlocBuilder<MediplanBloc, MediplanState>(
                builder: (context, mediplanState) {
                  List<Mission>? missions = mediplanState.missions
                      ?.where(
                        (Mission mission) =>
                            mission.start.day == _currentDate.day,
                      )
                      .toList();

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        itemCount: missions!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == missions.length - 1 ? 10 : 0,
                            ),
                            child: MissionTile(mission: missions[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 15);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
