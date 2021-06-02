import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/member_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/icon_check/icon_check.dart';
import 'package:sale_management/shares/widgets/prefix_person/prefix_person.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';

class MemberDropdownPage extends StatefulWidget {
  final Map vMember;
  const MemberDropdownPage({Key? key, required this.vMember}) : super(key: key);

  @override
  _MemberDropdownState createState() => _MemberDropdownState();
}

class _MemberDropdownState extends State<MemberDropdownPage> {
  var isNative = false;
  late Size size ;
  List<dynamic> vData = [];
  var styleInput;

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    styleInput = TextStyle(color: ColorsUtils.isDarkModeColor(), fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontDefault);
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: _buildAppBar(),
      body: Column(
          children: <Widget>[
            this.vData.length > 0 ? _buildBody() : CircularProgressLoading(),
          ],
        )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      elevation: DefaultStatic.elevationAppBar,
      title: Text('member.label.member'.tr()),
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
        child:  ListView.builder(
          itemCount: this.vData.length,
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
    if(widget.vMember.toString() != '{}' && widget.vMember[MemberKey.id] == dataItem[MemberKey.id] ) {
      isCheck = true;
    }
    return ListTile(
      onTap: () => onSelectedItem(dataItem),
      title: Text( dataItem[MemberKey.name],
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      leading: PrefixPerson(url: dataItem[MemberKey.url]),
      subtitle: Text(
        dataItem[MemberKey.remark],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontDefault, color: primaryColor),
      ),
      trailing:  isCheck ? IconCheck() : null,
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/member_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['members'];
    });
    return this.vData;
  }

  void onSelectedItem(Map data) {
    Navigator.pop(context, data);
  }

}
