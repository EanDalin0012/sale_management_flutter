import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class SaleDetails extends StatefulWidget {
  final Map vData;
  const SaleDetails({Key? key, required this.vData}) : super(key: key);

  @override
  _SaleDetailsState createState() => _SaleDetailsState();
}

class _SaleDetailsState extends State<SaleDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: ColorsUtils.scaffoldBackgroundColor()
      ),
      child: Column(
        children: <Widget>[
          _widgetStack(context),
          drawerHandler(),
        ],
      ),
    );
  }

  Widget _widgetStack(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: double.infinity,
            height: 35.0,
            child: Center(
                child: Text('View',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: ColorsUtils.isDarkModeColor())
                ) // Your desired title
            ),
          ),
          Positioned(
              left: 0.0,
              top: 0.0,
              child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowLeft,size: 20 , color: ColorsUtils.isDarkModeColor()), // Your desired icon
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              )
          )
        ]
    );
  }

  drawerHandler() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 4,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffd9dbdb)
      ),
    );
  }

}
