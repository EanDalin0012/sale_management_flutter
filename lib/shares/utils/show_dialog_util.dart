import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowDialogUtil {

  static void showDialogYesNo({
    required BuildContext buildContext,
    Widget? title,
    required Widget content,
    double? elevation,
    required VoidCallback onPressedYes,
    required VoidCallback onPressedNo,
  }) {
    showDialog(context: buildContext,
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 3,
              backgroundColor: Color(0xff273950),
              title: Center(child: title),
              content: content,
              actions: <Widget>[
                RaisedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    onPressedNo();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  label: Text('common.label.no'.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 18),),
                  icon: FaIcon(FontAwesomeIcons.timesCircle, size: 20, color: Colors.white),
                  textColor: Colors.white,
                  splashColor: Color(0xff273950),
                  color: Colors.redAccent,
                ),

                // RaisedButton.icon(
                //   onPressed: () {
                //     Navigator.of(context).pop(false);
                //     onPressedNo();
                //   },
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(50))),
                //   label: Text('common.label.no'.tr(),
                //     style: TextStyle(color: Colors.black),),
                //   icon: Icon(Icons.cancel_rounded, color: Colors.white,),
                //   textColor: Colors.white,
                //   splashColor: Colors.red,
                //   color: Colors.red,
                // ),
                // RaisedButton.icon(
                //   onPressed: () {
                //     Navigator.of(context).pop(false);
                //     onPressedYes();
                //   },
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(50))),
                //   label: Text('common.label.yes'.tr(),
                //     style: TextStyle(color: Colors.black),),
                //   icon: Icon(
                //     Icons.check_circle_outline_outlined, color: Colors.white,),
                //   textColor: Colors.white,
                //   splashColor: Colors.red,
                //   color: Colors.green,
                // ),

                RaisedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    onPressedYes();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  label: Text('common.label.yes'.tr(),
                    style: TextStyle(color: Colors.white,fontSize: 18),),
                  icon: FaIcon(FontAwesomeIcons.checkCircle, size: 20, color: Colors.white),
                  textColor: Colors.white,
                  splashColor: Color(0xff273950),
                  color: Colors.indigo,
                ),
              ]
          );
        });
  }

  static void dialog({
    required BuildContext buildContext,
    Widget? title,
    required Widget content,
    double? elevation,
  }) {
    showDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 5,
              backgroundColor: Color(0xff273950),
              title: Center(child: title),
              content: SingleChildScrollView(
                  child: content
              ),
              actions: <Widget>[
                RaisedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  label: Text('common.label.ok'.tr(),
                    style: TextStyle(color: Colors.white,fontSize: 18),),
                  icon: Icon(
                    Icons.check_circle_outline_outlined, color: Colors.white,),
                  textColor: Colors.white,
                  splashColor: Color(0xff273950),
                  color: Color(0xff273950),
                ),
              ]
          );
        });
  }

  static Widget _buildIconCheck() {
    return Container(
      width: 30,
      height: 30,
      child: Image(
          image: AssetImage('assets/icons/success-green-check-mark.png')),
    );
  }

}
