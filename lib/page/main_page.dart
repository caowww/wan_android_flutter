import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroidflutter/data/home_banner_data.dart';
import 'package:wanandroidflutter/data/home_data_page_result.dart';
import 'package:wanandroidflutter/http/http.dart';

/// Create Time 2020/5/5
/// @author caow
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  List<HomeData> _list;
  List<HomeBannerData> _topList;

  @override
  void initState() {
    super.initState();
    Http().getHomeData(0).then((bizResult) {
      setState(() {
        _list = bizResult.data.datas;
      });
    });
    Http().getHomeBannerData().then((bizResult) {
      setState(() {
        _topList = bizResult.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WanAndroid'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: getSwiper(),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return getListItem(index);
          }, childCount: _list != null ? _list.length : 0))
        ],
      ),
    );
  }

  Widget getSwiper() {
    return Container(
      height: 200,
      child: Swiper(
        itemCount: _topList != null ? _topList.length : 0,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          var data = _topList[index];
//          return Text(data.title);
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(data.imagePath), fit: BoxFit.fill)
            ),
          );
        },
      ),
    );
  }

  Widget getListItem(int index) {
    var data = _list[index];
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(data.title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Row(
            children: <Widget>[
              Text(data.author.length != 0 ? '作者:' : '分享人:', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 8),
                child: Text(data.author.length != 0 ? data.author : data.shareUser),
              ),
              Text('分类:', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 8),
                child: Text('${data.superChapterName}/${data.chapterName}'),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 8),
            child: Text(
              data.niceDate,
              style: TextStyle(color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }
}
