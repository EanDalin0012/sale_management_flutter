import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/language_key.dart';

class LanguageChoice extends StatefulWidget {
  final ValueChanged<Map> onChanged;
  final String code;
  const LanguageChoice({Key? key, required this.onChanged, required this.code}) : super(key: key);

  @override
  _LanguageChoiceState createState() => _LanguageChoiceState();
}

class _LanguageChoiceState extends State<LanguageChoice> {
  var color = Color(0xff32b8a1);
  var code = 'en';
  double kDefaultPadding = 20.0;
  var isCheckKh = false;
  var isCheckEn = false;
  var isCheckZn = false;
  var key = 'lang';
  List<dynamic> vData = [
    {
      LanguageKey.code: 'km',
      LanguageKey.text: 'ខ្មែរ',
      'url':'assets/countries/kh.svg'
    },
    {
      LanguageKey.code: 'en',
      LanguageKey.text: 'English',
      'url':'assets/countries/gb.svg'
    },{
      LanguageKey.code: 'zn',
      LanguageKey.text: '中文',
      'url':'assets/countries/cn.svg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    code = widget.code;
    return Container(
        height: MediaQuery.of(context).size.height * 0.37,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurple,
              child: Center(child: Text('Language', style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: fontDefault,
                  fontWeight: FontWeight.w500),)),
            ),
            Container(
              color: Colors.lightBlue[50]!.withOpacity(0.4),
              child: Column(
                children: vData.map((e) => _container(e)).toList(),
              ),
            ),
          ],
        )
    );
  }


  Widget _container(Map map) {
    var isCheck = false;
    if(map[LanguageKey.code] == code) {
      isCheck = true;
    }

    return InkWell(
      onTap: () {
        widget.onChanged(map);
        pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          border: isCheck ? Border(
            top: BorderSide(width: 2, color: color),
            bottom: BorderSide(width: 2, color: color),
          ): null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 45,
              height: 45,
              margin: EdgeInsets.all(15),
              // decoration: BoxDecoration(
              //     color: Colors.red
              // ),
              child: _buildFlag(map['url'].toString()),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.only(top: 10),
                child: Text(map[LanguageKey.text],style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: fontDefault)),
              ),
            ),
            isCheck ? _buildIconCheck() : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildIconCheck() {
    return Container(
      width: 40,
      height: 30,
      margin: EdgeInsets.only(right: 15),
      child: Image(image: AssetImage('assets/icons/success-green-check-mark.png')),
    );
  }

  Widget _buildFlag(String url) {
    return SvgPicture.asset(
      url.toString(),
      height: 50,
    );
  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }

}
