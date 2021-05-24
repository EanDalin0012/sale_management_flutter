import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';

class WidgetsUtil {

  static AppBar appBar({required String title, Widget? leading, List<Widget>? actions, PreferredSizeWidget? bottom, double? elevation}) {
    return AppBar(
      // backgroundColor: Colors.purple[900],
      title: Text(title),
      leading: leading,
      actions: actions,
      elevation: elevation,
      bottom: bottom,
    );
  }

  static AppBarTheme appBarTheme() {
    var color = Colors.purple[900];
    var iconThemeColor = Colors.white;
    var textThemeColor = Colors.white;
    if(DarkMode.isDarkMode == true) {
      color = Colors.black;
      iconThemeColor = Colors.white;
      textThemeColor = Colors.white;
    }
    return AppBarTheme(
      color: color,
      elevation: 2,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: iconThemeColor),
      textTheme: TextTheme(
        headline6: TextStyle(color: textThemeColor, fontSize: 18),
      ),
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: Color(0xFFEDE8FF)),
      gapPadding: 10,
    );
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
    );
  }

}