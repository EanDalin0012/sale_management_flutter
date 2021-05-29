import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/shares/statics/size_config.dart';

class BuildStatCard extends StatefulWidget {
  const BuildStatCard({Key? key}) : super(key: key);

  @override
  _BuildStatCardState createState() => _BuildStatCardState();
}

class _BuildStatCardState extends State<BuildStatCard> {
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
      child: Column(
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
      ),
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

}
