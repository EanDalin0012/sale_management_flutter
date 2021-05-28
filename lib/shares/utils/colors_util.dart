
import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';

class ColorsUtils {
    static Color scaffoldBackgroundColor() {
      return DarkMode.isDarkMode == true ? Color(0xff333436): Colors.white;
    }

    static Color textTheme() {
      return DarkMode.isDarkMode == true ?  Colors.white : Color(0xFF222B45);
    }

    static Color toastBackgroundContainer() {
      return DarkMode.isDarkMode == true ?  Color(0xff242527) : Colors.greenAccent;
    }

    static Color borderSideColor() {
      return DarkMode.isDarkMode == true ? Colors.white: kTextColor;
    }

    static Color? svgPictureSufFixIconColor() {
      return DarkMode.isDarkMode == true ? Colors.white : null;
    }

    static Color iConColor() {
      return DarkMode.isDarkMode == true ? Colors.white : Colors.black45;
    }

    static Color isDarkModeColor() {
      return DarkMode.isDarkMode == true ? Colors.white : Colors.black;
    }

    static Color unselectedWidgetColor() {
      return DarkMode.isDarkMode == true ? Colors.white.withOpacity(0.8) : Colors.black45;
    }

    static Color buttonContainer() {
      return DarkMode.isDarkMode == true ? Color(0xff242527) : Colors.red;
    }

    static Color buttonColorContainer() {
      return DarkMode.isDarkMode == true ? Colors.white:  Colors.white;
    }

    static Color? appBarBackGround() {
      return DarkMode.isDarkMode == true ?  Color(0xff242527) : Colors.purple[900];
    }
}
