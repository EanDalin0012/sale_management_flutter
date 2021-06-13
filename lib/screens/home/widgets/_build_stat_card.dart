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
  int i = 0;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  List<Color> _colors = [
    Color(0xff2f3935),
    Color(0xff2f3945),
    Color(0xff2f3955),
    Color(0xff2f3965),
    Color(0xff2f3975),
    Color(0xff2f3985),
    Color(0xff2f3995),
    Color(0xff2f4095)
  ];

  @override
  Widget build(BuildContext context) {
    var length = this.vData.length;
    this.i = 0;
    double h = MediaQuery
        .of(context)
        .size
        .height * 0.22;
    if (length > 2) {
      h = MediaQuery
          .of(context)
          .size
          .height * 0.44;
    }

    return this.vData.length > 0 ? Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Color(0xff2f3965), width: 6.0),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Sell Product'),
            Container(
              height: h,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: this.vData.length,
                  itemBuilder: (BuildContext context, int index) {
                    this.i = index;
                    if (this.i > this._colors.length - 1) {
                      this.i = 0;
                    }

                    return Container(
                      width: 200,
                      height: 40,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: this._colors[i],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(this.vData[index][ProductKey.name].toString()),
                          Text('100'),
                          Text('1000 USD')
                        ],
                      ),
                    );
                  }
              ),
            ),
          ]
      ),
    ) : Container();
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

  Widget _buildBody1() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Text('Product'),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    title: 'Total Case', count: '1.81 M', color: Colors.orange),
                _buildStatCard(
                    title: 'Total Case', count: '1.81 M', color: Colors.red)
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    title: 'Total Case', count: '1.81 M', color: Colors.green),
                _buildStatCard(title: 'Total Case',
                    count: '1.81 M',
                    color: Colors.lightBlue),
                _buildStatCard(
                    title: 'Total Case', count: '1.81 M', color: Colors.purple),
              ],
            ),
          )
        ]
    );
  }

  Expanded _buildStatCard(
      {required String title, required String count, MaterialColor? color }) {
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
            Text(title, style: TextStyle(color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600),),
            Text(count, style: TextStyle(color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString(
        'assets/json_data/product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['products'];
    });
    return this.vData;
  }

}
