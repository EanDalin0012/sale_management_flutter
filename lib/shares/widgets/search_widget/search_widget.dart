import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';

class SearchWidget extends StatelessWidget {
  final String text;
  final String hintText;
  final ValueChanged<String> onChanged;

  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  var focusedBorder;

  SearchWidget({Key? key, required this.text, required this.hintText, required this.onChanged}): super(key: key);

  @override
  Widget build(BuildContext context) {
    style = InputDecorationUtils.textFormFieldStyle();
    labelStyle = InputDecorationUtils.inputDecorationLabelStyle();
    hintStyle = InputDecorationUtils.inputDecorationHintStyle();
    enabledBorder = InputDecorationUtils.enabledBorder();
    focusedBorder = InputDecorationUtils.focusedBorder();

    return TextFormField(
        keyboardType: TextInputType.text,
        style: this.style,
        decoration: InputDecoration(
            labelStyle: this.labelStyle,
            hintText: hintText,
            hintStyle: this.hintStyle,
            contentPadding: EdgeInsets.only(left: 25, right: 15),
            fillColor: Colors.white,
            focusedBorder: this.focusedBorder,
            enabledBorder: this.enabledBorder,
            prefixIconConstraints: BoxConstraints(
              minWidth: 45,
            ),
            prefixIcon: Padding(
                padding: EdgeInsets.only(left: 15),
                child: FaIcon(FontAwesomeIcons.search, color: Colors.white, size: 18)
            )
        ),
        onChanged: (value) {
          this.onChanged(value);
        }
    );
  }
}
