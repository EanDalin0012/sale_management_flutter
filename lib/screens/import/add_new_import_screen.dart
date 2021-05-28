import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/import/widgets/add_new_import_body.dart';
import 'package:sale_management/screens/import/widgets/view_import_item.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class AddNewImportScreen extends StatefulWidget {
  const AddNewImportScreen({Key? key}) : super(key: key);

  @override
  _AddNewImportScreenState createState() => _AddNewImportScreenState();
}

class _AddNewImportScreenState extends State<AddNewImportScreen> {
  List<dynamic> vData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: AddNewImportBody(onAddChanged: (items) {
          setState(() {
            this.vData = items;
          });
        }),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Text('import.label.import'.tr(), style: TextStyle(fontFamily: fontDefault, fontWeight: FontWeight.w700, color: ColorsUtils.isDarkModeColor())),
        backgroundColor: ColorsUtils.appBarBackGround(),
        elevation: DefaultStatic.elevationAppBar,
        actions: <Widget>[
          GestureDetector(
            onTap: () => _showModelSheet(),
            child: Container(
              height: 80,
              width: 55,
              child: Stack(
                children: <Widget>[
                  Center(child:  FaIcon(FontAwesomeIcons.cartArrowDown,size: 25 , color: Colors.white,),),
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                        top: 5,
                        left: 30
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(child: Text(this.vData.length.toString(), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800))),
                  ),
                ],
              ),
            ),
          ),
        ]
    );
  }

   _showModelSheet() {
    var orientation = MediaQuery.of(context).orientation;
    double height = (MediaQuery.of(context).copyWith().size.height * 0.9);
    setState(() {
      if(orientation != Orientation.portrait){
        height = MediaQuery.of(context).copyWith().size.height * 0.5;
      }
    });

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.deepPurpleAccent.withOpacity(0.5)
            ),
            child: ViwImportItems(
              vData: this.vData,
              onChanged: (vChangeData) {
                setState(() {
                  this.vData = vChangeData;
                });
              },
            ),
          );
        });
  }

}
