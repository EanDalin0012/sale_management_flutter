import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/m_key.dart';
import 'package:sale_management/shares/widgets/icon_check/icon_check.dart';

class StockChoice extends StatefulWidget {
  final Map vStock;
  final List<dynamic> mList;
  final ValueChanged<Map> onChanged;
  const StockChoice({Key ? key, required this.vStock, required this.onChanged, required this.mList}) : super(key: key);

  @override
  _StockChoiceState createState() => _StockChoiceState();
}

class _StockChoiceState extends State<StockChoice> {

  List<dynamic> vData = [];
  var color = Color(0xff32b8a1);

  @override
  void initState() {
    this._fetchItemsStock();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.37,
        child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.deepPurple,
                child: Center(child: Text('Choose Stock', style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: fontDefault,
                    fontWeight: FontWeight.w500),)),
              ),
              this.vData.length > 0 ? SingleChildScrollView(
                child: Container(
                  color: Colors.lightBlue[50]!.withOpacity(0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: this.vData.map((e) => _container(e)).toList(),
                  ),
                ),
              ) : Container(),
            ]
        )
    );
  }

  Widget _container(Map map) {
    var isCheck = false;
    if(map[StockKey.id] == widget.vStock[StockKey.id]) {
      isCheck = true;
    }

    return GestureDetector(
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
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 50.0,
                padding: EdgeInsets.only(top: 10),
                child: Text(map[StockKey.name].toString(),style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: fontDefault)),
              ),
              isCheck ? IconCheck() : Container()
            ],
          ),
        ),
      ),
    );
  }

  _fetchItemsStock() async {
    final data = await rootBundle.loadString('assets/json_data/stock_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['stocks'];
    });
    return this.vData;
  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }

}
