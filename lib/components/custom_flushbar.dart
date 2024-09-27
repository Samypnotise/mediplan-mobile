import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/constants/flushbar_type.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomFlushbar(BuildContext context, String title, String message,
    Widget icon, FlushbarType type) {
  List<Color> gradientColors = [
    MediplanColors.primary,
    MediplanColors.secondary,
  ];

  switch (type) {
    case FlushbarType.info:
      gradientColors = [
        MediplanColors.primary,
        MediplanColors.secondary,
      ];
      break;

    case FlushbarType.success:
      gradientColors = [
        MediplanColors.successDarker,
        MediplanColors.successDarker
      ];
      break;

    case FlushbarType.warning:
      gradientColors = [
        MediplanColors.warningDarker,
        MediplanColors.warningDarker
      ];
      break;

    case FlushbarType.danger:
      gradientColors = [
        MediplanColors.dangerDarker,
        MediplanColors.dangerDarker
      ];
      break;
    default:
  }
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.only(
      top: 10,
      left: 20,
      right: 20,
    ),
    padding: const EdgeInsets.only(
      top: 10,
      bottom: 15,
      left: 20,
      right: 20,
    ),
    borderRadius: BorderRadius.circular(20),
    backgroundGradient: LinearGradient(colors: gradientColors),
    icon: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: icon,
    ),
    animationDuration: const Duration(milliseconds: 1500),
    duration: const Duration(seconds: 3),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.elasticInOut,
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Shadow color
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 3), // Shadow position
      ),
    ],
    titleText: Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w900,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.bold,
        fontSize: 14.5,
        color: Colors.white,
      ),
    ),
  ).show(context);
}
