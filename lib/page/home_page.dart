import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroidflutter/data/home_banner_data.dart';
import 'package:wanandroidflutter/data/home_data_page_result.dart';
import 'package:wanandroidflutter/http/http.dart';
import 'package:wanandroidflutter/page/web_page.dart';
import 'package:wanandroidflutter/utils/navigator_utils.dart';

/// Create Time 2020/5/5
/// @author caow
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<HomeData> _list;
  List<HomeBannerData> _topList;
  int page = 0;

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
    return EasyRefresh.custom(
//        header: MaterialHeader(),
//        footer: MaterialFooter(),
        onRefresh: () async {
          var list = await Http().getHomeData(0);
          var topList = await Http().getHomeBannerData();
          setState(() {
            page = 0;
            _list = list.data.datas;
            _topList = topList.data;
          });
        },
        onLoad: () async {
          var list = await Http().getHomeData(page + 1);
          setState(() {
            page++;
            if (_list != null) {
              _list.addAll(list.data.datas);
            } else {
              _list = list.data.datas;
            }
          });
        },
//        child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: getSwiper(),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return getListItem(index);
          }, childCount: _list != null ? _list.length : 0))
        ],
//        ),
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
          return FlatButton(
            onPressed: () {
              NavigatorUtils.push(context, WebPage(title: data.title, url: data.url));
            },
            padding: EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data.imagePath), fit: BoxFit.fill)),
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 16),
                  color: Color(0x33000000),
                  child: Text(
                    data.title,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget getListItem(int index) {
    var data = _list[index];
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      child: FlatButton(
        onPressed: () {
          NavigatorUtils.push(
              context,
              WebPage(
                url: data.link,
                title: data.title,
              ));
        },
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
      ),
    );
  }
}
