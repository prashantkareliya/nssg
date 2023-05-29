import 'package:flutter/material.dart';

class AppColors {
  static Color blackColor = Colors.black;
  static Color whiteColor = Colors.white;
  static Color transparent = Colors.transparent;
  static Color hintFontColor = Colors.grey.shade400;

  static Color backWhiteColor = const Color(0xFFF1F4F8);
  static Color borderColor = const Color(0xFFD9D9D9);
  static Color darkGray = const Color(0xFFA5A5A5);

  static Color primaryColor = const Color(0xFF1E5CA4);
  static Color primaryColorLawOpacity = const Color(0xFF1E5CA4).withOpacity(0.10);
  static Color loaderColor = const Color(0xFF1E5CA4).withOpacity(0.5);
  static Color primaryColorLawOpacityBack = const Color(0xFFE2E9F1);
  static Color fontColor = const Color(0xFF333333);
  static Color redColor = const Color(0xFFA41E1E);
  static Color redColorSwitch = const Color(0xFFE9514E);

  static Color blueAccentColor = const Color(0xFF1E5CA4);
  static Color greenColor = const Color(0xFF0B702D);
  static Color greenColorAccent = const Color(0xFF8BC24A);
  static Color greenColorAccept = const Color(0xFF00AC26);

  static int _hash(String value) {
    int hash = 0;
    value.runes.forEach((code) {
      hash = code + ((hash << 2) - hash);
    });
    return hash;
  }

  static Color stringToColor(String value) {
    return Color(stringToHexInt(value));
  }

  static String stringToHexColor(String value) {
    String c = (_hash(value) & 0x00FFFFFF).toRadixString(16).toUpperCase();
    return "0xFF000000".substring(0, 10 - c.length) + c;
  }

  static int stringToHexInt(String value) {
    String c = (_hash(value) & 0x00FFFFFF).toRadixString(16).toUpperCase();
    String hex = "FF000000".substring(0, 8 - c.length) + c;
    return int.parse(hex, radix: 16);
  }
}
