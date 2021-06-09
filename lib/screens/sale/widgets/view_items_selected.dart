import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/sale_add_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/number_format.dart';

import 'build_data_table_sale.dart';

class ViewItemsSelected extends StatefulWidget {
  final List<dynamic> vData;
  final ValueChanged<List<dynamic>> onChanged;

  const ViewItemsSelected(
      {Key? key, required this.vData, required this.onChanged})
      : super(key: key);

  @override
  _ViewItemsSelectedState createState() => _ViewItemsSelectedState();
}

class _ViewItemsSelectedState extends State<ViewItemsSelected> {
  var i = 0;
  var total = 0.0;

  @override
  Widget build(BuildContext context) {
    i = 0;
    this.total = 0;
    if (widget.vData.length > 0) {
      widget.vData.map((e) =>
      this.total += double.parse(e[SaleAddItemKey.total].toString())).toList();
    }

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: ColorsUtils.scaffoldBackgroundColor(),
        ),
        child: Column(
          children: <Widget>[
            _widgetStack(context),
            drawerHandler(),
            BuildDataTableSale(vData: widget.vData, onChanged: widget.onChanged)
          ],
        )
    );
  }

  Widget _widgetStack(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: double.infinity,
            height: 35.0,
            child: Center(
                child: Text('sale.label.saleItemSelect'.tr(),
                    style: TextStyle(fontFamily: fontDefault,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: ColorsUtils.isDarkModeColor())
                ) // Your desired title
            ),
          ),
          Positioned(
              left: 0.0,
              top: 0.0,
              child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowLeft, size: 20,
                      color: ColorsUtils.isDarkModeColor()),
                  // Your desired icon
                  onPressed: () {
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
