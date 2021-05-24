import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/category_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/icon_check/icon_check.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryDropdownPage extends StatefulWidget {
  final Map vCategory;

  CategoryDropdownPage({Key? key, required this.vCategory}) : super(key: key);

  @override
  _CategoryDropdownPageState createState() => _CategoryDropdownPageState();
}

class _CategoryDropdownPageState extends State<CategoryDropdownPage> {

  var styleInput;
  var isNative = false;
  var text = '';
  var controller = TextEditingController();
  var isItemChanged = false;

  List<dynamic> vData = [];
  List<dynamic> vDataTmp = [];
  var vDataLength = 0;
  late Size size;

  @override
  void initState() {
    super.initState();
    this._fetchListItems();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    styleInput = TextStyle(color: ColorsUtils.isDarkModeColor(), fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontDefault);
    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: <Widget>[
            if (vDataLength > 0 ) _buildBody() else CircularProgressLoading(),
          ],
        )
    );
  }


  AppBar _buildAppBar() {
    final label = 'categoryDropdown.label.chooseCategory'.tr();

    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('$label'),
      actions: [
        IconButton(
          icon: Icon(this.isNative ? Icons.close : Icons.search),
          onPressed: ()  {
            setState(()  {
              if(this.isNative) {
                this.vData = vDataTmp;
                this.vDataLength = this.vData.length;
              }
              this.isNative = !this.isNative;
            });
          },
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: size.width - 20,
                height: 65,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: SearchWidget(
                  hintText: 'search.label.searchName'.tr(),
                  text: 'search.label.search'.tr(),
                  onChanged: (value) {
                    setState(() {
                      this.vData = onItemChanged(value);
                      this.vDataLength = this.vData.length;
                    });
                  },
                )
            ),
          ],
        ),
      ) : null,
    );
  }

  Widget _buildBody () {
    return Expanded(
        child:  ListView.separated(
          itemCount: vDataLength,
          separatorBuilder: (context, index) => Divider(
            color: ColorsUtils.isDarkModeColor(),
          ),
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: this.vData[index]
            );
          },
        )
    );
  }

  Widget _buildListTile({
    required Map dataItem
  }) {
    var isCheck = false;
    if(widget.vCategory != null && widget.vCategory[CategoryKey.id] == dataItem[CategoryKey.id] ) {
      isCheck = true;
    }
    return ListTile(
      onTap: () => onSelectedItem(dataItem),
      title: Text( dataItem[CategoryKey.name],
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      subtitle: Text(
        dataItem[CategoryKey.remark],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontDefault, color: primaryColor),
      ),
      trailing:  isCheck ? IconCheck() : null,
    );
  }


  void onSelectedItem(Map data) {
    Navigator.pop(context, data);
  }

  onItemChanged(String value) {
    var dataItems = vDataTmp.where((e) => e[CategoryKey.name].toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }

  _fetchListItems() async {
    final data = await rootBundle.loadString('assets/json_data/category_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['categoryList'];
      this.vDataTmp = this.vData;
      this.vDataLength = this.vData.length;
    });
    return this.vData;
  }


}
