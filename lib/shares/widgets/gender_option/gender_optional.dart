import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GenderForm extends FormField<String> {
  GenderForm({
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    required ValueChanged<String > onChanged,
    String ? initialValue,
    bool autovalidate = false,
    required Size size,
  }):super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidate: autovalidate,
    builder: (FormFieldState<String> state) {
      var validateColor = state.hasError ? Colors.red : Colors.black;
      return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('genderForm.label.gender'.tr()),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    state.didChange('m');
                    onChanged('m');
                  },
                  child: Container(
                    width: (size.width / 2 ) - 40,
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: initialValue != null ? Colors.indigo : validateColor),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child:  Text('genderForm.label.male'.tr()),
                        ),
                        Radio(
                          value: 'm',
                          activeColor: Colors.indigo,
                          groupValue: initialValue,
                          onChanged: (v) => onChanged(v.toString())
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    state.didChange('f');
                    onChanged('f');
                  },
                  child: Container(
                    width: (size.width / 2 ) - 40,
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: initialValue != null ? Colors.indigo : validateColor),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child:  Text('genderForm.label.female'.tr()),
                        ),
                        Radio(
                          value: 'f',
                          activeColor: Colors.indigo,
                          groupValue: initialValue,
                          onChanged: (v) => onChanged(v.toString())
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            state.hasError ? Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                state.errorText!,
                style: TextStyle(
                    color: Colors.red
                ),
              ),
            ) : Container()
          ]
      );
    });
}
