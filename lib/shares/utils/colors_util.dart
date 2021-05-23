
import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';

class ColorsUtils {
    static Color scaffoldBackgroundColor() {
      var color = Colors.white;
      if(DarkMode.isDarkMode == true) {
        color = Colors.black;
      }
      return color;
    }

    static Color textTheme() {
      var color = Color(0xFF222B45);
      if(DarkMode.isDarkMode == true) {
        color = Colors.white;
      }
      return color;
    }

    static Color borderSideColor() {
      var color = kTextColor;
      if(DarkMode.isDarkMode == true) {
        color = Colors.white;
      }
      return color;
    }

    static Color? svgPictureSufFixIconColor() {
      if(DarkMode.isDarkMode == true) {
        return Colors.white;
      }
      return null;
    }

    static Color iConColor() {
      if(DarkMode.isDarkMode == true) {
        return Colors.white;
      }
      return Colors.black45;
    }

    static Color isDarkModeColor() {
      if(DarkMode.isDarkMode == true) {
        return Colors.white;
      }
      return Colors.black;
    }

    static Color unselectedWidgetColor() {
      if(DarkMode.isDarkMode == true) {
        return Colors.white.withOpacity(0.8);
      }
      return Colors.black45;
    }
}
