import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        color: MediplanColors.primary,
        backgroundColor: MediplanColors.inputBackground,
        strokeCap: StrokeCap.round,
        strokeWidth: 6,
      )),
    );
  }
}
