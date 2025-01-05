import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediplan/components/custom_flushbar.dart';
import 'package:mediplan/constants/flushbar_type.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:map_launcher/map_launcher.dart' as map_launcher;
import 'package:mediplan/models/mission.dart';

Future<dynamic> showMapsSelectionModal(
  BuildContext context,
  Mission mission,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    barrierColor: MediplanColors.blur,
    context: context,
    builder: (context) {
      double phoneHeight = MediaQuery.of(context).size.height;

      return SizedBox(
        height: phoneHeight * 0.32,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              //! Titre de la modale
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.mapPin,
                    size: 30,
                    color: MediplanColors.secondary,
                  ),
                  // Spacer to push the text to the center
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Choisissez une application",
                        style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.w900,
                          color: MediplanColors.secondary,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.mapPin,
                    size: 30,
                    color: MediplanColors.secondary,
                  ),
                ],
              ),

              const Spacer(),

              //! Apple Plans
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? isMapAvailable =
                          await map_launcher.MapLauncher.isMapAvailable(
                              map_launcher.MapType.apple);

                      if (isMapAvailable!) {
                        await map_launcher.MapLauncher.showMarker(
                          mapType: map_launcher.MapType.apple,
                          coords: map_launcher.Coords(
                            mission.latitude,
                            mission.longitude,
                          ),
                          title: mission.title,
                        );
                      } else {
                        showCustomFlushbar(
                          // ignore: use_build_context_synchronously
                          context,
                          'Application non trouvée',
                          "Veuillez installer l'application et réessayer.",
                          const FaIcon(
                            FontAwesomeIcons.solidFaceDizzy,
                            color: Colors.white,
                            size: 30,
                          ),
                          FlushbarType.warning,
                        );
                      }
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
                          FontAwesomeIcons.apple,
                          size: 35,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Apple Plans",
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //! Google Maps
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? isMapAvailable =
                          await map_launcher.MapLauncher.isMapAvailable(
                              map_launcher.MapType.google);

                      if (isMapAvailable!) {
                        await map_launcher.MapLauncher.showMarker(
                          mapType: map_launcher.MapType.google,
                          coords: map_launcher.Coords(
                            mission.latitude,
                            mission.longitude,
                          ),
                          title: mission.title,
                        );
                      } else {
                        showCustomFlushbar(
                          // ignore: use_build_context_synchronously
                          context,
                          'Application non trouvée',
                          "Veuillez installer l'application et réessayer.",
                          const FaIcon(
                            FontAwesomeIcons.solidFaceDizzy,
                            color: Colors.white,
                            size: 30,
                          ),
                          FlushbarType.warning,
                        );
                      }
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
                          FontAwesomeIcons.google,
                          size: 30,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Google Maps",
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
    },
  );
}
