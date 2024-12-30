import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_bloc.dart';
import 'package:mediplan/components/mission_swap_modal.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission_swap.dart';

class MissionSwapTile extends StatelessWidget {
  final MissionSwap missionSwapDemand;
  const MissionSwapTile({
    super.key,
    required this.missionSwapDemand,
  });

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    final MediplanBloc mediplanBloc = context.read<MediplanBloc>();

    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white, // Background color
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
          onTap: () {
            showMissionSwapModal(context, mediplanBloc, missionSwapDemand);
          },
          borderRadius: BorderRadius.circular(20),
          splashColor: MediplanColors.quaternary,
          child: Stack(
            children: [
              //! Date de la mission
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 120,
                  height: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(10),
                    ),
                    color: MediplanColors.secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Center(
                      child: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(missionSwapDemand.mission.start),
                        style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //! Contenu de la mission
              Padding(
                padding: const EdgeInsets.only(
                  top: 44,
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Heure de la mission
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.solidClock,
                            color: Colors.black,
                            size: 22,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "${DateFormat("HH:mm").format(missionSwapDemand.mission.start)} - ${DateFormat("HH:mm").format(missionSwapDemand.mission.end)}",
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //! Nom du patient
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.solidUser,
                              color: Colors.black,
                              size: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: phoneWidth * 0.5,
                                child: Text(
                                  missionSwapDemand.mission.patient,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //! Titre de la mission
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.syringe,
                            color: Colors.black,
                            size: 22,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: phoneWidth * 0.64,
                              child: Text(
                                missionSwapDemand.mission.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //! Nom du soignant qui souhaite echanger la mission
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: phoneWidth * 0.83,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: phoneWidth * 0.5,
                        height: 25,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: MediplanColors.tertiary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.userNurse,
                                color: Colors.white,
                                size: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "${missionSwapDemand.sender.lastName.toUpperCase()} ${missionSwapDemand.sender.firstName}",
                                  style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
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
            ],
          ),
        ),
      ),
    );
  }
}
