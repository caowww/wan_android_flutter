import 'package:flutter/material.dart';
import 'package:wanandroidflutter/page/home_page.dart';
import 'package:wanandroidflutter/page/mine_page.dart';

/// Create Time 2020/5/7
/// @author caow
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  var _tabIndex = 0;
  List<Widget> _pageList = [
    HomePage(),
    MinePage(),
  ];

  var _tabList = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.perm_identity), title: Text('我的')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WanAndroid'),
        centerTitle: true,
      ),
      body: IndexedStack(
        children: _pageList,
        index: _tabIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabList,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
