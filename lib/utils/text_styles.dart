import 'package:amazone_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle buttonTextStyle =
      GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle inputTextStyle = GoogleFonts.openSans(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppTheme.primeryColor1);
  static TextStyle hintTextStyle = GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppTheme.primeryColor1.withValues(alpha: .5));
  static TextStyle primeryText20 = GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.primeryColor1);
  static TextStyle headerStyleOne =
      GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w500);
}
