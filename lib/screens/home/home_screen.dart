import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/widgets/home_container.dart';
import 'package:sale_management/screens/home/widgets/my_drawer.dart';
import 'package:sale_management/screens/home/widgets/sheet_container.dart';
import 'package:sale_management/screens/sale/sale_screen.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class HomeScreen extends StatefulWidget {
  final int selectIndex;
  const HomeScreen({Key? key, required this.selectIndex}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  String _titleBar = 'home.label.home'.tr();
  var isShowAppBar = true;
  List<Widget> _widgetOptions = <Widget>[
    HomeContainer(),
    SaleScreen()
  ];


  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectIndex;
    if(_selectedIndex == 1) {
      this.isShowAppBar = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        appBar: isShowAppBar ? _appBar() : null,
        drawer: MyDrawer(),
        bottomNavigationBar: _bottomNavigationBar(),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_titleBar),
      backgroundColor: ColorsUtils.appBarBackGround(),
      elevation: DefaultStatic.elevationAppBar,
      leading: Builder(builder: (context) {
        return IconButton(
            icon: Icon(Icons.sort_rounded),
            onPressed: () => Scaffold.of(context).openDrawer());
      },),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => NotificationScreen()),
            // );
          },
          child: Container(
            height: 80,
            width: 55,
            child: Stack(
              children: <Widget>[
                Center(child: Icon(Icons.notifications)),
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
                  child: Center(child: Text('2', style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800))),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 5,
          color: Colors.white,
        )
      ],
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    double activeIconSize = 36;
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xff273965),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.home,
            color: kGoodLightGray,
          ),
          title: Text('HOME'),
          activeIcon: Icon(
            FeatherIcons.home,
            color: kGoodPurple,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.plusCircle,
            color: kGoodLightGray,
          ),
          title: Text('CALENDAR'),
          activeIcon: Icon(
            FeatherIcons.plusCircle,
            color: kGoodPurple,
            size: activeIconSize,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.alignLeft,
            color: kGoodLightGray,
          ),
          title: Text('PROFILE'),
          activeIcon: Icon(
            FeatherIcons.alignLeft,
            color: kGoodPurple,
            size: activeIconSize,
          ),
        ),
      ],
      onTap: (index) {
        setState(() {
          if (index == 0) {
            isShowAppBar = true;
            _titleBar = 'Home';
          } else if (index == 1) {
            _titleBar = 'Sale';
            isShowAppBar = false;
          }
          if (index >= 2) {
            _showModelSheet();
          } else {
            _selectedIndex = index;
          }
        });
      },
    );
  }

  void _showModelSheet() {
    var orientation = MediaQuery
        .of(context)
        .orientation;
    double height = (MediaQuery
        .of(context)
        .copyWith()
        .size
        .height * 0.6);
    setState(() {
      if (orientation != Orientation.portrait) {
        height = MediaQuery
            .of(context)
            .copyWith()
            .size
            .height * 0.5;
      }
    });
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return Container(
            height: height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: SheetContainer(),
          );
        });
  }

  Future<bool> onBackPress() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 3,
              backgroundColor: Color(0xff273950),
              title: Center(child: Text('common.label.exitApp'.tr(), style: TextStyle(color: ColorsUtils.isDarkModeColor()),)),
              content: Text('common.label.doYouWantToExitApp'.tr(), style: TextStyle(color: ColorsUtils.isDarkModeColor())),
              actions: <Widget>[
                Container(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2f3945)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            )
                        )
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: 0,
                          top: 10.0,
                          child: Text('common.label.no'.tr(), style: TextStyle(
                              fontFamily: fontDefault,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.red)
                          ),
                        ),
                        Positioned(
                            left: 0,
                            top: 10.0,
                            child: FaIcon(FontAwesomeIcons.timesCircle, size: 20, color: Colors.red)
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),

                Container(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff273965)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            )
                        )
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: 0,
                          top: 10.0,
                          child: Text('common.label.yes'.tr(), style: TextStyle(
                              fontFamily: fontDefault,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white)
                          ),
                        ),
                        Positioned(
                            left: 0,
                            top: 10.0,
                            child: FaIcon(FontAwesomeIcons.checkCircle, size: 20, color: Colors.white)
                        ),
                      ],
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                ),
              ]
          );
        }
    );
    return Future<bool>.value(false);
  }


}
