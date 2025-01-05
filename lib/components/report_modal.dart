import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/components/confirmation_modal.dart';
import 'package:mediplan/components/input_widget.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission.dart';

Future<dynamic> showReportModal(
  BuildContext context,
  Mission mission,
) {
  return showModalBottomSheet(
    isScrollControlled: true, // To adjust size
    backgroundColor: Colors.white,
    barrierColor: MediplanColors.blur,
    context: context,
    builder: (context) {
      double phoneHeight = MediaQuery.of(context).size.height;
      double phoneWidth = MediaQuery.of(context).size.width;

      // Listen to keyboard height dynamically
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

      // Calculate the height based on keyboard visibility
      double heightMultiplicator = keyboardHeight > 0 ? 1.5 : 0.75;

      return ReportView(
        phoneHeight: phoneHeight,
        heightMultiplicator: heightMultiplicator,
        phoneWidth: phoneWidth,
        mission: mission,
      );
    },
  );
}

class ReportView extends StatefulWidget {
  const ReportView({
    super.key,
    required this.phoneHeight,
    required this.heightMultiplicator,
    required this.phoneWidth,
    required this.mission,
  });

  final double phoneHeight;
  final double heightMultiplicator;
  final double phoneWidth;
  final Mission mission;

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.phoneHeight * widget.heightMultiplicator,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            //! Titre de la modale
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.fileMedical,
                  size: 30,
                  color: MediplanColors.primary,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Compte rendu de la mission",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: MediplanColors.primary,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),

            //! Date de la mission
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidCalendarDays,
                    size: 30,
                    color: MediplanColors.tertiary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${DateFormat("dd/MM/yyyy").format(widget.mission.start)}  •  ${DateFormat("HH:mm").format(widget.mission.start)} - ${DateFormat("HH:mm").format(widget.mission.end)}",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //! Nom du patient
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 30,
                    color: MediplanColors.tertiary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Patient(e) :",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.mission.patient,
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //! Intitule de la mission
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.syringe,
                    size: 30,
                    color: MediplanColors.tertiary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Mission :",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: widget.phoneWidth * 0.85,
                  child: Padding(
                    padding: EdgeInsets.only(left: widget.phoneWidth * 0.1),
                    child: Text(
                      widget.mission.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            //! Divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(
                thickness: 4,
                color: MediplanColors.quaternary,
              ),
            ),

            const Spacer(),

            //! Comptes rendus ecrits et vocaux
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! Compte rendu ecrit
                SizedBox(
                  width: widget.phoneWidth * 0.68,
                  child: const Input(
                    prefixIcon: FaIcon(
                      FontAwesomeIcons.pen,
                      color: MediplanColors.secondary,
                    ),
                    placeholder: "Compte rendu de la mission.",
                    multiline: true,
                    heightMultiplicator: 0.22,
                  ),
                ),

                //! Lecture et enregistrement du compte rendu
                SizedBox(
                  height: widget.phoneHeight * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! Lecture du compte rendu s'il y en a un
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: _isPlaying
                              ? MediplanColors.danger
                              : MediplanColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          child: InkWell(
                            splashColor: MediplanColors.quaternary,
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              // TODO : Lire le message vocal de l'utilisateur
                              setState(() {
                                _isPlaying = !_isPlaying;
                              });
                            },
                            child: Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: _isPlaying ? 0 : 3),
                                child: FaIcon(
                                  _isPlaying
                                      ? FontAwesomeIcons.pause
                                      : FontAwesomeIcons.play,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //! Compte rendu vocal
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: _isRecording
                              ? MediplanColors.danger
                              : MediplanColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          child: InkWell(
                            splashColor: MediplanColors.quaternary,
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              // TODO : Demander a l'utilisateur s'il veut ecraser l'enregistrement existant
                              // TODO : Enregistrer le message vocal de l'utilisateur
                              setState(() {
                                _isRecording = !_isRecording;
                              });
                            },
                            child: Center(
                              child: FaIcon(
                                _isRecording
                                    ? FontAwesomeIcons.stop
                                    : FontAwesomeIcons.microphone,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //! Bouton de sauvegarde du compte rendu
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 10,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO : Sauvegarder le compte rendu dans la DB
                    showConfirmationModal(
                      context,
                      heightMultiplicator: 0.3,
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.triangleExclamation,
                            size: 30,
                            color: MediplanColors.danger,
                          ),
                          // Spacer to push the text to the center
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Sauvegarde en cours",
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.w900,
                                  color: MediplanColors.danger,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          const FaIcon(
                            FontAwesomeIcons.triangleExclamation,
                            size: 30,
                            color: MediplanColors.danger,
                          ),
                        ],
                      ),
                      "Voulez-vous vraiment sauvegarder ce compte rendu ?",
                      () => Navigator.of(context).pop(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MediplanColors.primary,
                    elevation: 5,
                    shadowColor: MediplanColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidFloppyDisk,
                        size: 25,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Sauvegarder",
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MediplanColors.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
