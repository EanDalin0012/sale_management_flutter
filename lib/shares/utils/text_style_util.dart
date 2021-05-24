import 'package:flutter/material.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class TextStyleUtils {

  static TextStyle headingStyle() {
    return TextStyle(
        fontSize: getProportionateScreenWidth(28),
        fontWeight: FontWeight.bold,
        color: ColorsUtils.isDarkModeColor(),
        height: 1.5
    );
  }
}
