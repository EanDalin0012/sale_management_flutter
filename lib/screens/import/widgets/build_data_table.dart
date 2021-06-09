import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/import_add_key.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/widgets/prefix_product/prefix_product.dart';

class BuildDataTable extends StatefulWidget {
  final List<dynamic> vData;
  final ValueChanged<List<dynamic>> onChanged;

  const BuildDataTable({Key? key, required this.vData, required this.onChanged})
      : super(key: key);

  @override
  _BuildDataTableState createState() => _BuildDataTableState();
}

class _BuildDataTableState extends State<BuildDataTable> {
  var textStyle;
  var i = 0;
  var total = 0.0;

  @override
  Widget build(BuildContext context) {
    textStyle = TextStyle(color: ColorsUtils.isDarkModeColor());
    i = 0;
    this.total = 0;
    if (widget.vData.length > 0) {
      widget.vData.map((e) =>
      this.total += double.parse(e[ImportAddKey.total].toString())).toList();
    }

    return Column(
        children: <Widget>[
          Text(
            'import.label.totalParam'.tr(args: [
              FormatNumberUtils.usdFormat2Digit(total.toString() + ' USD')
                  .toString()
            ]),
            style: TextStyle(fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: fontDefault,
                color: ColorsUtils.isDarkModeColor()),
          ),
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
        ]
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
            label: Text('import.label.product'.tr(), style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.packageProduct'.tr(), style: textStyle),
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
                DataCell(Text(i.toString(), style: textStyle)),
                DataCell(
                    Row(
                        children: <Widget>[
                          PrefixProduct(
                              url: product[ProductKey.url].toString()),
                          SizedBox(width: 10),
                          Text(product[ProductKey.name].toString(),
                              style: textStyle)
                        ]
                    )
                ),
                DataCell(Text(packageProduct[PackageProductKey.name].toString(),
                    style: textStyle)),
                DataCell(Text(
                    e[ImportAddKey.quantity].toString(), style: textStyle)),
                DataCell(Text(e[ImportAddKey.total].toString() + ' \$',
                    style: textStyle)),
                DataCell(_buildRemoveButton(e))
              ]
          );
        }

        ).toList()
    );
  }

  Widget _buildRemoveButton(Map<dynamic, dynamic> item) {
    return Container(
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
          icon: FaIcon(
              FontAwesomeIcons.minusCircle, size: 20, color: Colors.white),
          label: Text('common.label.remove'.tr(), style: TextStyle(
              fontFamily: fontDefault,
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.white))
      ),
    );
  }

}
