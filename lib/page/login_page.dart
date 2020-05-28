import 'package:flutter/material.dart';

/// Create Time 2020/5/7
/// @author caow
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('登录'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Color(0x66000000), offset: Offset(1.0, 1.0), blurRadius: 5.0, spreadRadius: 1.0),
            ],
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
//          child: ,
        ),
      ),
    );
  }
}
