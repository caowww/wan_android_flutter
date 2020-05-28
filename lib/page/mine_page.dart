import 'package:flutter/material.dart';
import 'package:wanandroidflutter/page/login_page.dart';
import 'package:wanandroidflutter/utils/navigator_utils.dart';

/// Create Time 2020/5/7
/// @author caow
class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          NavigatorUtils.push(context, LoginPage());
        },
        child: Text('登录'),
      ),
    );
  }
}
