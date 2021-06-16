import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetAppBarAction extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool isNative;
  const WidgetAppBarAction({Key? key, required this.onChanged, required this.isNative}) : super(key: key);

  @override
  _WidgetAppBarActionState createState() => _WidgetAppBarActionState();
}

class _WidgetAppBarActionState extends State<WidgetAppBarAction> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.isNative ? _crossButton() : _searchButton(),
      onPressed: () => widget.onChanged(!widget.isNative)
    );
  }

  Widget _crossButton() {
    return Container(
      height: 25,
      width: 25,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Color(0xff6E747F),
            borderRadius: BorderRadius.circular(50)
        ),
        child: Center(child: FaIcon(FontAwesomeIcons.timesCircle, size: 16, color: Colors.white,))
    );
  }

  Widget _searchButton() {
    return Container(
      height: 25,
      width: 25,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: Color(0xff6E747F),
            borderRadius: BorderRadius.circular(50)
        ),
        child: Center(child: FaIcon(FontAwesomeIcons.search, size: 15, color: Colors.white,))
    );
  }

}
