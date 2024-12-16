import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final TextInputType? textInputType;
  final bool? isPassword;
  final String? passwordCharacter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final bool? isError;
  final bool? multiline;
  final double? heightMultiplicator;

  const Input({
    super.key,
    required this.placeholder,
    this.passwordCharacter = "●",
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.onChanged,
    this.isError,
    this.multiline = false,
    this.heightMultiplicator = 0.065,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: textInputType,
        obscureText: isPassword!,
        obscuringCharacter: passwordCharacter!,
        maxLines: multiline! ? null : 1,
        expands: multiline!,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        style: GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          constraints: BoxConstraints(
            maxHeight: height * heightMultiplicator!,
            maxWidth: width,
          ),
          filled: true,
          fillColor: MediplanColors.inputBackground,
          hintText: placeholder,
          hintStyle: GoogleFonts.sourceSansPro(
            fontWeight: FontWeight.bold,
            color: MediplanColors.placeholder,
            fontSize: 14,
          ),
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [prefixIcon ?? const SizedBox()],
          ),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [suffixIcon ?? const SizedBox()],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: MediplanColors.inputBackground,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: MediplanColors.inputBackground,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: MediplanColors.inputBackground,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
