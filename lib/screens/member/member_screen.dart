import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/member/add_new_member_screen.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/constants/text_style.dart';
import 'package:sale_management/shares/model/key/member_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/show_dialog_util.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';
import 'package:sale_management/shares/widgets/prefix_person/prefix_person.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {

  var isNative = false;
  late Size size ;
  List<dynamic> vData = [];
  var vDataLength = 0;

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
        child: WillPopScope(
          onWillPop:  () => onBackPress(),
          child: GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
            },
            child: Column(
              children: <Widget>[
                OverListItem(
                  text: 'member.label.memberList'.tr(),
                  length: this.vData.length,
                ),
                this.vData.length > 0 ? _buildBody() : CircularProgressLoading()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _floatingActionButton()

    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      title: Text('member.label.member'.tr()),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            this.isNative = !isNative;
            // this.isItemChanged = false;
            // this.isFilterByProduct = false;
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

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddNewMemberScreen()),
        );
      },
      tooltip: 'packageProduct.label.addNewProductPackage'.tr(),
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  Widget _buildBody () {
    return Expanded(
        child: ListView.separated(
          itemCount: this.vData.length,
          separatorBuilder: (context, index) => Divider(
            color: ColorsUtils.isDarkModeColor(),
          ),
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
    print(dataItem.toString());
    return ListTile(
      title: Text( dataItem[MemberKey.name],
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      leading: PrefixPerson(url: dataItem[MemberKey.url]),
      subtitle: Text(
        dataItem[MemberKey.phone],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontDefault, color: primaryColor),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _offsetPopup(dataItem),
        ],
      ),
    );
  }

  Widget _offsetPopup(Map item) => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 0,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.edit,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                'common.label.edit'.tr(),
                style: menuStyle,
              ),
            ],
          )
      ),
      PopupMenuItem(
          value: 1,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.trash,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                'common.label.delete'.tr(),
                style: menuStyle,
              ),
            ],
          )
      ),
    ],
    icon: FaIcon(FontAwesomeIcons.ellipsisV,size: 20,color: ColorsUtils.isDarkModeColor()),
    offset: Offset(0, 45),
    onSelected: (value) {
      if(value == 0) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => EditCategoryScreen(vData: item)),
        // );
      } else if (value == 1) {
        _showDialog(item);
      }
    },
  );

  void _showDialog(Map item) {
    ShowDialogUtil.showDialogYesNo(
        buildContext: context,
        title: Text(item[MemberKey.name]),
        content: Text('member.message.doYouWantToDeleteMember'.tr(args: [item[MemberKey.name]])),
        onPressedYes: () {
          print('onPressedBntRight');
        },
        onPressedNo: () {
          print('onPressedBntLeft');
        }
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return Future<bool>.value(true);
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/member_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['members'];
    });
    return this.vData;
  }
}
