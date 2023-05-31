import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context){
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.grey[900] : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
    );
  }

  static List<Color> gradientColors(bool isDarkTheme, BuildContext context){
    if (isDarkTheme) {
      return const <Color>[
        Color(0xff241663),
        Color(0xff21195b),
        Color(0xff1f1b53),
        Color(0xff1e1c4a),
        Color(0xff1e1d41),
        Color(0xff1e1e38),
        Color(0xff1e1e2f),
        Color(0xff1e1e26),
      ];
    } else {
      return const <Color>[
        Color(0xffa6bcff),
        Color(0xff99b1f9),
        Color(0xff8da6f2),
        Color(0xff809bec),
        Color(0xff7390e5),
        Color(0xff6685de),
        Color(0xff587ad8),
        Color(0xff4970d1),
      ];
    }
  }
}