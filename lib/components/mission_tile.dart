import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/blocs/navigation_bloc/navigation_cubit.dart';
import 'package:mediplan/components/google_map_modal.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission.dart';

class MissionTile extends StatelessWidget {
  final Mission mission;
  const MissionTile({
    super.key,
    required this.mission,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity, // To take the whole width given
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: MediplanColors.quaternary, // Shadow color
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 4), // Shadow position
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
            // showGoogleMapModal(context, mission);
            context.read<NavigationCubit>().showCurrentMissionView(mission);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidClock,
                      color: Colors.black,
                      size: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "${DateFormat("HH:mm").format(mission.start)} - ${DateFormat("HH:mm").format(mission.end)}",
                        style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                //! Titre de la mission
                Text(
                  mission.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    color: MediplanColors.secondary,
                    fontSize: 16,
                  ),
                ),

                //! Nom du patient
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: MediplanColors.placeholder,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        mission.patient,
                        style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: MediplanColors.placeholder,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
