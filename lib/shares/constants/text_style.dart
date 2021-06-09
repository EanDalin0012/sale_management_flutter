import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

var borderColorsTextField = Colors.deepPurple;
var labelStyle = TextStyle(
    fontSize: 20, color: Colors.deepPurple, fontFamily: fontDefault);
var hintStyle = TextStyle(fontFamily: fontDefault);
var containStyle = TextStyle(color: ColorsUtils.isDarkModeColor(),
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: fontDefault);
var appBarStyle = TextStyle(
    fontFamily: fontDefault, fontWeight: FontWeight.w700);
var menuStyle = TextStyle(color: Colors.purple[900],
    fontWeight: FontWeight.w500,
    fontFamily: fontDefault);

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);
