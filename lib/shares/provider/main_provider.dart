import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';

class MainProvider extends ChangeNotifier {
  ThemeData themeData = ThemeData.light();
  bool _darkTheme = false;

  bool get darkTheme => DarkMode.isDarkMode;

  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }

  ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      fontFamily: fontDefault,
      appBarTheme: WidgetsUtil.appBarTheme(),
      unselectedWidgetColor: ColorsUtils.unselectedWidgetColor(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: ColorsUtils.borderSideColor()),
      gapPadding: 10,
    );
    return InputDecorationTheme(
      labelStyle: InputDecorationUtils.inputDecorationLabelStyle(),
      hintStyle: InputDecorationUtils.inputDecorationHintStyle(),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      enabledBorder: InputDecorationUtils.enabledBorder(),
      focusedBorder: InputDecorationUtils.focusedBorder(),
      border: outlineInputBorder,
    );
  }

  TextTheme textTheme() {
    return TextTheme(
      bodyText1: TextStyle(color: ColorsUtils.isDarkModeColor()),
      bodyText2: TextStyle(color: ColorsUtils.isDarkModeColor()),

    );
  }

  // AppBarTheme appBarTheme() {
  //   return AppBarTheme(
  //     color: Colors.purple[900],
  //     elevation: 2,
  //     brightness: Brightness.light,
  //     iconTheme: IconThemeData(color: Colors.white),
  //     textTheme: TextTheme(
  //       headline6: TextStyle(color: Colors.white, fontSize: 18),
  //     ),
  //   );
  // }

  setDarkMode(ThemeData thm) {
    themeData = thm;
    notifyListeners();
  }
}
