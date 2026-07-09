import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const cream     = Color(0xFFFAF3E6);
  static const sky       = Color(0xFFC8E6F5);
  static const skyMid    = Color(0xFFA8D4EC);
  static const skyDeep   = Color(0xFF7BB8D8);
  static const tan       = Color(0xFFCDA877);
  static const tanPale   = Color(0xFFEDD9AA);
  static const ink       = Color(0xFF4A3020);
  static const inkLight  = Color(0xFF7A5C40);
  static const blue      = Color(0xFF3A6A8C);
  static const blueLight = Color(0xFF5E90B0);
  static const gold      = Color(0xFFB8820A);
  static const white     = Color(0xFFFFFFFF);
  static const green     = Color(0xFF2E7D4F);
}

class AppTextStyles {
  static TextStyle display(bool isAr, double size, Color color) {
    if (isAr) {
      return GoogleFonts.arefRuqaa(
        fontSize: size, fontWeight: FontWeight.w700, color: color,
      );
    }
    return GoogleFonts.cormorantGaramond(
      fontSize: size, fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600, color: color,
    );
  }

  static TextStyle script(bool isAr, double size, Color color) {
    if (isAr) {
      return GoogleFonts.arefRuqaa(
        fontSize: size, fontWeight: FontWeight.w700, color: color,
      );
    }
    return GoogleFonts.caveat(
      fontSize: size, fontWeight: FontWeight.w700, color: color,
    );
  }

  static TextStyle body(bool isAr, double size, Color color) {
    if (isAr) {
      return GoogleFonts.tajawal(
        fontSize: size, fontWeight: FontWeight.w400, color: color,
      );
    }
    return GoogleFonts.jost(
      fontSize: size, fontWeight: FontWeight.w400, color: color,
    );
  }

  static TextStyle label(bool isAr, double size, Color color) {
    if (isAr) {
      return GoogleFonts.tajawal(
        fontSize: size, fontWeight: FontWeight.w600, color: color,
      );
    }
    return GoogleFonts.jost(
      fontSize: size, fontWeight: FontWeight.w600, color: color,
      letterSpacing: 0.5,
    );
  }
}
