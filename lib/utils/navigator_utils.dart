import 'package:flutter/material.dart';

/// Create Time 2020/5/7
/// @author caow
class NavigatorUtils {
  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
