import 'package:flutter/material.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';

class SearchWidget extends StatelessWidget {
  final String text;
  final String hintText;
  final ValueChanged<String> onChanged;
  const SearchWidget({Key? key, required this.text, required this.hintText, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white, fontSize: 20),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white54),
            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.white54,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.white54,
              ),
            ),
            prefixIcon: CustomSuffixIcon(svgPaddingLeft: 15, svgIcon: "assets/icons/Search Icon.svg")
        ),
        onChanged: (value) {
          this.onChanged(value);
        }
    );
  }
}
