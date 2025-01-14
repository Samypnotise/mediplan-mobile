import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_bloc.dart';
import 'package:mediplan/blocs/mission_swap_bloc/mission_swap_bloc.dart';
import 'package:mediplan/blocs/mission_swap_bloc/mission_swap_event.dart';
import 'package:mediplan/blocs/mission_swap_bloc/mission_swap_state.dart';
import 'package:mediplan/components/custom_flushbar.dart';
import 'package:mediplan/constants/flushbar_type.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission_swap.dart';
import 'package:mediplan/repositories/mission_swap_repository.dart';
import 'package:mediplan/status/form_submission_status.dart';

Future<dynamic> showMissionSwapModal(
  BuildContext context,
  MediplanBloc mediplanBloc,
  MissionSwap missionSwapDemand,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    barrierColor: MediplanColors.blur,
    context: context,
    builder: (context) {
      double phoneHeight = MediaQuery.of(context).size.height;

      return RepositoryProvider(
        create: (context) => MissionSwapRepository(),
        child: BlocProvider(
          create: (context) => MissionSwapBloc(
            mediplanBloc: mediplanBloc,
            missionSwapRepository: context.read<MissionSwapRepository>(),
            missionSwapDemand: missionSwapDemand,
          ),
          child: BlocListener<MissionSwapBloc, MissionSwapState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              final isDemandStatusAccepted = state.demandStatus == 'ACCEPTED';

              if (formStatus is SubmissionFailed) {
                showCustomFlushbar(
                  context,
                  'Demande non traitée ...',
                  "Veuillez réessayer ultérieurement.",
                  const FaIcon(
                    FontAwesomeIcons.solidFaceDizzy,
                    color: Colors.white,
                    size: 30,
                  ),
                  FlushbarType.warning,
                );
              }

              if (formStatus is SubmissionSuccess) {
                showCustomFlushbar(
                  context,
                  'Demande ${isDemandStatusAccepted ? 'acceptée' : 'refusée'} !',
                  "La demande d'échange a bien été ${isDemandStatusAccepted ? 'acceptée' : 'refusée'}.",
                  FaIcon(
                    isDemandStatusAccepted
                        ? FontAwesomeIcons.solidCircleCheck
                        : FontAwesomeIcons.solidCircleXmark,
                    color: Colors.white,
                    size: 30,
                  ),
                  isDemandStatusAccepted
                      ? FlushbarType.success
                      : FlushbarType.danger,
                );
              }
            },
            child: SizedBox(
              height: phoneHeight * 0.50,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    //! Titre de la modale
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.arrowRightArrowLeft,
                          size: 30,
                          color: MediplanColors.danger,
                        ),
                        // Spacer to push the text to the center
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Échange de mission",
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.w900,
                                color: MediplanColors.danger,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        const FaIcon(
                          FontAwesomeIcons.arrowRightArrowLeft,
                          size: 30,
                          color: MediplanColors.danger,
                        ),
                      ],
                    ),

                    const Spacer(),

                    //! Message d'information de la modale
                    Text(
                      "Voulez-vous vraiment accepter la demande d'échange de ${missionSwapDemand.sender.lastName.toUpperCase()} ${missionSwapDemand.sender.firstName} pour le ${DateFormat('dd/MM/yyyy').format(missionSwapDemand.mission.start)} à ${DateFormat('HH:mm').format(missionSwapDemand.mission.start)} ?",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),

                    const Spacer(),

                    //! Titre de la mission
                    Text(
                      "Résumé : ${missionSwapDemand.mission.title}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.sourceSansPro(
                        color: MediplanColors.placeholder,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),

                    const Spacer(),

                    //! Bouton permettant d'accepter la demande
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: BlocBuilder<MissionSwapBloc, MissionSwapState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<MissionSwapBloc>().add(
                                    DemandStatusChanged(
                                      demandStatus: 'ACCEPTED',
                                    ),
                                  );

                              context.read<MissionSwapBloc>().add(
                                    MissionSwapDemandUpdated(
                                      missionSwapDemandId:
                                          missionSwapDemand.id!,
                                    ),
                                  );

                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MediplanColors.primary,
                              elevation: 3,
                              shadowColor: MediplanColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Accepter la demande",
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: MediplanColors.background,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    //! Bouton permettant de refuser la demande
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: BlocBuilder<MissionSwapBloc, MissionSwapState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                //! TODO : Idee de refactor : creer un evenement puis dans cet evenement faire le traitement du rejet
                                context.read<MissionSwapBloc>().add(
                                      DemandStatusChanged(
                                        demandStatus: 'REJECTED',
                                      ),
                                    );

                                context.read<MissionSwapBloc>().add(
                                      MissionSwapDemandUpdated(
                                        missionSwapDemandId:
                                            missionSwapDemand.id!,
                                      ),
                                    );

                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MediplanColors.danger,
                                elevation: 3,
                                shadowColor: MediplanColors.danger,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.solidCircleXmark,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Refuser la demande",
                                      style: GoogleFonts.sourceSansPro(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: MediplanColors.background,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
