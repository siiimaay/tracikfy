import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  final TextStyle companyNameText;
  final TextStyle detailText;

  TextThemeExtension({
    required this.companyNameText,
    required this.detailText,
  });

  @override
  ThemeExtension<TextThemeExtension> copyWith() {
    return TextThemeExtension(
        companyNameText: companyNameText, detailText: detailText);
  }

  @override
  ThemeExtension<TextThemeExtension> lerp(
      covariant ThemeExtension<TextThemeExtension>? other, double t) {
    return TextThemeExtension(
        companyNameText: companyNameText, detailText: detailText);
  }

  static TextThemeExtension textStyles() {
    return TextThemeExtension(
      companyNameText: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        //color: AppColors.textFieldHintTextColor,
      ),
      detailText: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
