import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/statics/size_config.dart';

class DefaultButton  extends StatelessWidget {
  final String? text;
  final Function press;
  final Color? color;
  final double? borderRadiusCircular;
  final double? elevation;
  const DefaultButton({
    Key? key,
    this.text,
    this.color,
    this.elevation,
    this.borderRadiusCircular,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    Color _color = kPrimaryColor;
    double _borderRadius = 20;
    double _elevation = 2.0;
    if(this.elevation != null) {
      _elevation = this.elevation!;
    }
    if(this.borderRadiusCircular !=null) {
      _borderRadius = this.borderRadiusCircular!;
    }
    if (this.color != null) {
      _color = color!;
    }
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
        color: _color,
        elevation: _elevation,
        highlightElevation: 8.0,
        disabledElevation: 0.0,
        onPressed: () {
          press();
        },
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
