import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class TwoTabs extends StatefulWidget {
  final String textTab0;
  final String textTab1;
  final ValueChanged<int> onChanged;

  const TwoTabs(
      {Key? key, required this.textTab0, required this.textTab1, required this.onChanged})
      : super(key: key);

  @override
  _TwoTabsState createState() => _TwoTabsState();
}

class _TwoTabsState extends State<TwoTabs> {
  String _place = "tab0";
  late Size size;
  double w = 0.0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    w = (size.width / 2) - 30;

    return Container(
        height: 50.0,
        //width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.only(left: 5,top: 4, bottom: 4, right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0XFFAEA1E5).withOpacity(0.3)
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    setState(() {
                      _place = "tab0";
                      widget.onChanged(0);
                    });
                  },
                  child: Container(
                      width: w,
                      padding: EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 40.0),
                      decoration: BoxDecoration(
                          color: _place == "tab0" ? ColorsUtils
                              .twoTabContainer() : null,
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Text(
                                widget.textTab0,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: _place != "tab0"
                                    ? Color(0xff2f3953)
                                    : Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: fontDefault),
                              ),
                            ]
                        )
                  )
              ),

              InkWell(
                  onTap: () {
                    setState(() {
                      _place = "tab1";
                      widget.onChanged(1);
                    });
                  },
                  child: Container(
                      width: w,
                      height: 45,
                      padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 35.0),
                      decoration: BoxDecoration(
                          color: _place == "tab1" ? ColorsUtils.twoTabContainer() : null,
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                widget.textTab1,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: _place != "tab1"
                                    ? Color(0xff2f3953)
                                    : Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ]
                        ),
                  )
              )
              // GestureDetector()
            ]
        )
    );
  }
}
