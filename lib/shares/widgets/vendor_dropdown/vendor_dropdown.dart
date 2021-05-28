import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/vendor_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/icon_check/icon_check.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class VendorDropdownPage extends StatefulWidget {
  final Map vVendor;

  const VendorDropdownPage({Key? key, required this.vVendor}) : super(key: key);

  @override
  _VendorDropdownPageState createState() => _VendorDropdownPageState();
}

class _VendorDropdownPageState extends State<VendorDropdownPage> {
  var isNative = false;
  late Size size ;
  List<dynamic> vData = [];

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this.vData.length > 0 ? _buildBody() : CircularProgressLoading()
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      title: Text('vendor.label.selectVendors'.tr()),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            this.isNative = !isNative;
          }),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: size.width - 40,
              height: 65,
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'search.label.searchName'.tr(),
                text: 'search.label.searchName'.tr(),
                onChanged: (value) {
                },
              ),
            ),
            // _buildFilterByCategory()
            // _buildFilterByProduct()
          ],
        ),
      ): null,
    );
  }

  Widget _buildBody () {
    return Expanded(
        child: ListView.builder(
          itemCount: this.vData.length,
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: this.vData[index]
            );},
        )
    );
  }

  Widget _buildListTile( {
    required Map dataItem
  }) {
    return ListTile(
      onTap: () => onSelectedItem(dataItem),
      title: Text( dataItem[VendorKey.name],
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      subtitle: Text(
        dataItem[VendorKey.phone] + ',' +dataItem[VendorKey.email],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontDefault, color: primaryColor),
      ),
      trailing: widget.vVendor.toString() != 'null' && widget.vVendor[VendorKey.id] == dataItem[VendorKey.id] ? IconCheck() : null,
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/vendor_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['vendors'];
    });
    return this.vData;
  }

  void onSelectedItem(Map data) {
    Navigator.pop(context, data);
  }

}
