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
}
