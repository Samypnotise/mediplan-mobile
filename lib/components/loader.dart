import 'package:flutter/material.dart';
import 'package:mediplan/constants/mediplan_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: MediplanColors.secondary,
        backgroundColor: MediplanColors.inputBackground,
        strokeCap: StrokeCap.round,
        strokeWidth: 6,
      ),
    );
  }
}
