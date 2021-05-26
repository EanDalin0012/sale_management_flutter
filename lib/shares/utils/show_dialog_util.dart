import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class ShowDialogUtil {

  static void showDialogYesNo( {
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
            elevation:elevation,
            title: Center(child: title),
            content: content,
              actions: <Widget>[
                RaisedButton.icon(
                  onPressed: (){
                    Navigator.of(context).pop(false);
                    onPressedNo();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  label: Text('common.label.no'.tr(),
                    style: TextStyle(color: Colors.black),),
                  icon: Icon(Icons.cancel_rounded, color:Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.red,
                ),
                RaisedButton.icon(
                  onPressed: (){
                    Navigator.of(context).pop(false);
                     onPressedYes();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  label: Text('common.label.yes'.tr(),
                    style: TextStyle(color: Colors.black),),
                  icon: Icon(Icons.check_circle_outline_outlined, color:Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.green,
                ),

              ]
          );
    });
  }

  static Widget _buildIconCheck() {
    return Container(
      width: 30,
      height: 30,
      child: Image(image: AssetImage('assets/icons/success-green-check-mark.png')),
    );
  }

}
