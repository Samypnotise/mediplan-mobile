import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_bloc.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/blocs/navigation_bloc/navigation_cubit.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;

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

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //! Nombre de missions de la journée dans une tile
                    MissionsToday(phoneWidth: phoneWidth),

                    //! Nombre d'échanges en attente de confirmation
                    MissionSwapTiles(phoneWidth: phoneWidth),
                  ],
                ),
              ),

              //! Prochaine missions dans : (nombre d'heures et minutes)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: NextMissionTile(phoneWidth: phoneWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MissionsToday extends StatelessWidget {
  const MissionsToday({
    super.key,
    required this.phoneWidth,
  });

  final double phoneWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: phoneWidth * 0.40,
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
      child: Stack(
        children: [
          const Positioned(
            top: 5,
            right: 5,
            child: FaIcon(
              FontAwesomeIcons.staffSnake,
              color: MediplanColors.secondary,
            ),
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              splashColor: MediplanColors.quaternary,
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                context.read<NavigationCubit>().showPlanningView();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 10,
                ),
                child: BlocBuilder<MediplanBloc, MediplanState>(
                  builder: (context, mediplanState) {
                    List<Mission>? todayMissions = mediplanState.missions
                        ?.where(
                          (Mission mission) =>
                              mission.start.isAfter(DateTime.now()),
                        )
                        .toList();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //! Nombre de missions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "${todayMissions?.length}",
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: MediplanColors.secondary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "mission${todayMissions!.length > 1 ? "s" : ""}",
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //! Hint
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
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MissionSwapTiles extends StatelessWidget {
  const MissionSwapTiles({
    super.key,
    required this.phoneWidth,
  });

  final double phoneWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: phoneWidth * 0.40,
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
      child: Stack(
        children: [
          const Positioned(
            top: 5,
            right: 5,
            child: FaIcon(
              FontAwesomeIcons.handHoldingMedical,
              color: MediplanColors.secondary,
            ),
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              splashColor: MediplanColors.quaternary,
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                context.read<NavigationCubit>().showMissionSwapView();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //! Nombre d'échanges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "5", // TODO : Inclure le nombre de missions à partir du state Mediplan
                          style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: MediplanColors.secondary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "échanges",
                            style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //! Hint
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
        ],
      ),
    );
  }
}

class NextMissionTile extends StatelessWidget {
  const NextMissionTile({
    super.key,
    required this.phoneWidth,
  });

  final double phoneWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
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
          borderRadius: BorderRadius.circular(20),
          splashColor: MediplanColors.quaternary,
          onTap: () {
            // context.read<NavigationCubit>().showCurrentMissionView();
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<MediplanBloc, MediplanState>(
              builder: (context, mediplanState) {
                List<Mission>? missions = mediplanState.missions
                    ?.where((Mission mission) =>
                        mission.start.isAfter(DateTime.now()))
                    .toList();

                return missions!.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //! Titre de la tile
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.truckMedical,
                                color: MediplanColors.secondary,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Mission à venir :",
                                      style: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        DateFormat("dd/MM")
                                            .format(missions[0].start),
                                        style: GoogleFonts.sourceSansPro(
                                          fontWeight: FontWeight.bold,
                                          color: MediplanColors.secondary,
                                          fontSize: 27,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          //! Titre de la mission
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.syringe,
                                color: Colors.black,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: phoneWidth * 0.65,
                                  child: Text(
                                    missions[0].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //! Nom du patient
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidUser,
                                color: Colors.black,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: phoneWidth * 0.65,
                                  child: Text(
                                    missions[0].patient,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //! Horaires de la mission
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidClock,
                                color: Colors.black,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: phoneWidth * 0.65,
                                  child: Text(
                                    "${DateFormat("HH:mm").format(missions[0].start)} - ${DateFormat("HH:mm").format(missions[0].end)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //! Hint
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
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous n'avez pas de mission aujourd'hui.",
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
