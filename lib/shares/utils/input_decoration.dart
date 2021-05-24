import 'package:flutter/material.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';

class InputDecorationUtils {
  static TextStyle inputDecorationLabelStyle() {
    if(DarkMode.isDarkMode == true) {
      return TextStyle(color: Colors.white);
    }
    return TextStyle(color: Colors.black.withOpacity(0.8));
  }

  static TextStyle inputDecorationHintStyle() {
    if(DarkMode.isDarkMode == true) {
      return TextStyle(color: Colors.white60);
    }
    return TextStyle(color: Colors.black54);
  }

  static TextStyle textFormFieldStyle () {
    if(DarkMode.isDarkMode == true) {
      return TextStyle(color: Colors.white);
    }
    return TextStyle(color: Colors.black);
  }
  static OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: DarkMode.isDarkMode ? Colors.white : Colors.black),
      gapPadding: 10,
    );
  }
  static OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: DarkMode.isDarkMode ? Colors.white : Colors.black87,
        width: 1.0,
      ),
    );
  }
}
