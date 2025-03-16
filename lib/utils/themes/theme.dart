import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme = ThemeData(
    fontFamily: GoogleFonts.kiwiMaru().fontFamily,
    brightness: Brightness.light,
    primaryColor: ConstantColors.secondary,
    scaffoldBackgroundColor: ConstantColors.fourth,
    appBarTheme: AppBarTheme(
      backgroundColor: ConstantColors.transparent,
      surfaceTintColor: ConstantColors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: ConstantColors.sixth,
        size: ConstantSizes.iconMd,
      ),
      actionsIconTheme: IconThemeData(
        color: ConstantColors.sixth,
        size: ConstantSizes.iconMd,
      ),
      centerTitle: false,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.kiwiMaru(
        color: ConstantColors.sixth,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: ConstantColors.darkGrey,
      suffixIconColor: ConstantColors.darkGrey,
      labelStyle: const TextStyle().copyWith(
        fontSize: ConstantSizes.fontSizeMd,
        color: ConstantColors.black,
      ),
      hintStyle: const TextStyle().copyWith(
        fontSize: ConstantSizes.fonConstantSizesm,
        color: ConstantColors.black,
      ),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: const TextStyle().copyWith(
        color: ConstantColors.black.withOpacity(0.8),
      ),
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: ConstantColors.grey),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: ConstantColors.grey),
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: ConstantColors.third),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: ConstantColors.warning),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 2, color: ConstantColors.warning),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ConstantColors.primary,
      selectionColor: ConstantColors.sixth.withOpacity(0.5),
      selectionHandleColor: ConstantColors.transparent,
    ),
  );
}
