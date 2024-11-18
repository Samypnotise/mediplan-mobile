import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediplan/constants/mediplan_colors.dart';

class MissionSwapView extends StatelessWidget {
  const MissionSwapView({super.key});

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
              //! Page title
              Row(
                children: [
                  Text(
                    "Échanges de missions",
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              //! Page description
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Remarque: Vous ne pourrez voir que le personnel ayant un emploi du temps n'entrant pas en conflit avec la mission sélectionnée.",
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: MediplanColors.placeholder,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.red,
                          height: 550,
                          width: 30,
                        ),
                        const Text("toto"),
                      ],
                    ),
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
