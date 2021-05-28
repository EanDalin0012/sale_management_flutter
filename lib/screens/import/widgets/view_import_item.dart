import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/import_add_key.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/widgets/prefix_product/prefix_product.dart';
import 'package:easy_localization/easy_localization.dart';

class ViwImportItems extends StatefulWidget {
  final List<dynamic> vData;
  final ValueChanged<List<dynamic>> onChanged;
  const ViwImportItems({Key? key, required this.vData, required this.onChanged}) : super(key: key);

  @override
  _ViwImportItemsState createState() => _ViwImportItemsState();
}

class _ViwImportItemsState extends State<ViwImportItems> {
  Color _iconColor = Color(0xff4A148CFF);
  var i = 0;
  var total = 0.0;


  @override
  Widget build(BuildContext context) {

    i = 0;
    this.total = 0;
    if(widget.vData.length > 0) {
      widget.vData.map((e) => this.total += double.parse(e[ImportAddKey.total].toString())).toList();
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
          Text(
            'import.label.totalParam'.tr(args: [FormatNumber.usdFormat2Digit(total.toString() + ' USD').toString()]),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: fontDefault, color: ColorsUtils.isDarkModeColor()),
          ),
          if (widget.vData.length > 0 )
            Column(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                          children: <Widget>[
                            _buildDataTable(),
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          // Container(
          //   height: 39,
          //   color: Colors.red,
          // )
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
                child: Text('import.label.importItems'.tr(),
                    style: TextStyle(fontFamily: fontDefault, fontWeight: FontWeight.w700, fontSize: 20, color: ColorsUtils.isDarkModeColor())
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

  Widget _buildDataTable() {
    var textStyle = TextStyle(color: ColorsUtils.isDarkModeColor());
    return DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text('import.label.no'.tr(), style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.product'.tr(),style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.packageProduct'.tr(),style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.quantity'.tr(), style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.total'.tr(), style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.action'.tr(), style: textStyle),
          ),
        ],
        rows: widget.vData.map((e) {
          i += 1;
          Map product = e[ImportAddKey.product];
          Map packageProduct = e[ImportAddKey.packageProduct];
          return DataRow(
              cells: <DataCell>[
                DataCell(Text(i.toString())),
                DataCell(
                    Row(
                        children: <Widget>[
                          PrefixProduct(url:  product[ProductKey.url].toString()),
                          SizedBox(width: 10),
                          Text(product[ProductKey.name].toString())
                        ]
                    )
                ),
                DataCell(Text(packageProduct[PackageProductKey.name].toString())),
                DataCell(Text(e[ImportAddKey.quantity].toString())),
                DataCell(Text(e[ImportAddKey.total].toString() + ' \$')),
                DataCell(_buildRemoveButton(e))
              ]
          );
        }

        ).toList()
    );
  }

  Widget _buildRemoveButton(Map<dynamic, dynamic> item) {
    return  Container(
      height: 35,
      width: 120,
      child: RaisedButton.icon(
          color: Colors.red,
          elevation: 4.0,
          onPressed: () {
            setState(() {
              widget.vData.remove(item);
              widget.onChanged(widget.vData);
            });
          },
          icon: FaIcon(FontAwesomeIcons.minusCircle,size: 20 , color: Colors.white),
          label: Text('common.label.remove'.tr(),style: TextStyle(fontFamily: fontDefault, fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white))
      ),
    );
  }


}
