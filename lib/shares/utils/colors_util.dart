
import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';

class ColorsUtils {
    static Color scaffoldBackgroundColor() {
      return DarkMode.isDarkMode == true ? Colors.black: Colors.white;
    }

    static Color textTheme() {
      var color = Color(0xFF222B45);
      if(DarkMode.isDarkMode == true) {
        color = Colors.white;
      }
      return color;
    }

    static Color borderSideColor() {
      if(DarkMode.isDarkMode == true) {
        return Colors.white;
      }
      return kTextColor;
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

    static Color buttonContainer() {
      if(DarkMode.isDarkMode == true) {
        return Colors.white;
      }
      return Colors.red;
    }

    static Color buttonColorContainer() {
      if(DarkMode.isDarkMode == true) {
        return Colors.black;
      }
      return Colors.white;
    }

    static Color? appBarBackGround() {
      return DarkMode.isDarkMode == true ?  Colors.black : Colors.purple[900];
    }
}
