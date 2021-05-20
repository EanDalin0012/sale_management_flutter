import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:sale_management/screens/home/widgets/home_container.dart';
import 'package:sale_management/screens/home/widgets/my_drawer.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  String _titleBar = 'home.label.home'.tr();
  var isShowAppBar = true;

  List<Widget> _widgetOptions = <Widget>[
    HomeContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowAppBar ? _appBar(): null,
      drawer: MyDrawer(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_titleBar),
      backgroundColor: Colors.purple[900],
      elevation: 0,
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
                Center(child:  Icon(Icons.notifications)),
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
                  child: Center(child: Text('2', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800))),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    double activeIconSize = 36;
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
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
          if(index == 0) {
            isShowAppBar = true;
            _titleBar = 'Home';
          } else if (index == 1) {
            _titleBar = 'Sale';
            isShowAppBar = false;
          }
          if(index >= 2) {
            // _showModelSheet();
          } else {
            _selectedIndex = index;
          }
        });
      },
    );
  }

  // Future<bool> _onBackPressed() {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Are you sure?'),
  //         content: Text('You are going to exit the application!!'),
  //         actions: [],
  //       );
  //     }
  //   );
  // }


}
