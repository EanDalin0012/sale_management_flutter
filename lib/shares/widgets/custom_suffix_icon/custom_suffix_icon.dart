import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class CustomSuffixIcon extends StatelessWidget {
  double? svgPaddingLeft;
  String svgIcon;

  CustomSuffixIcon({
    Key? key,
    this.svgPaddingLeft,
    required this.svgIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double left = 0;
    if (this.svgPaddingLeft != null) {
      left = this.svgPaddingLeft!;
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(20),
        color: ColorsUtils.svgPictureSufFixIconColor(),
      ),
    );
  }
}
