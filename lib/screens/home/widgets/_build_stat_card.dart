import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/size_config.dart';

class BuildStatCard extends StatefulWidget {
  const BuildStatCard({Key? key}) : super(key: key);

  @override
  _BuildStatCardState createState() => _BuildStatCardState();
}

class _BuildStatCardState extends State<BuildStatCard> {
  List<dynamic> vData = [];


  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Color(0xFFe4e6eb), width: 6.0),
      ),
      child:  this.vData.length > 0 ? _widget(): Container()
    );
  }

  Widget _widget() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(4),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      crossAxisCount: this.vData.length,
      children: this.vData.map((e) {
        return Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(10.0),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(e[ProductKey.name].toString()),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBody() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Text('Product'),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(title: 'Total Case', count: '1.81 M', color: Colors.orange),
                _buildStatCard(title: 'Total Case', count: '1.81 M', color: Colors.red)
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(title: 'Total Case', count: '1.81 M', color: Colors.green),
                _buildStatCard(title: 'Total Case', count: '1.81 M', color: Colors.lightBlue),
                _buildStatCard(title: 'Total Case', count: '1.81 M', color: Colors.purple),
              ],
            ),
          )
        ]
    );
  }

  Expanded _buildStatCard({required String title, required String count, MaterialColor? color }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w600),),
            Text(count, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['products'];
    });
    return this.vData;
  }

}
