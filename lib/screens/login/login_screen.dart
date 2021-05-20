import 'package:flutter/material.dart';
import 'package:sale_management/screens/login/widgets/login_body.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Login"),
      ),
      body: SafeArea(
        child: LoginBody(),
      ),
    );
  }
}
