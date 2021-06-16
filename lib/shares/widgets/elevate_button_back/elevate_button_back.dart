import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:easy_localization/easy_localization.dart';

class ElevatedButtonBack extends StatelessWidget {
  final VoidCallback onPressed;
  const ElevatedButtonBack({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - getProportionateScreenWidth(70),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff273965)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                )
            )
        ),
        child: Stack(
          children: <Widget>[
            Center(child: Text('common.label.back'.tr(), style: TextStyle(
                fontFamily: fontDefault,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white),)
            ),
            Positioned(
                left: 0,
                top: 12.5,
                child: FaIcon(FontAwesomeIcons.arrowCircleLeft, size: 25, color: Colors.white)
            ),
          ],
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
