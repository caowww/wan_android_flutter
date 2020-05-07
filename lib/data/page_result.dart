import 'package:wanandroidflutter/data/result.dart';

/// Create Time 2020/5/5
/// @author caow
class PageResult<T> {
  int curPage;
  List<T> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  PageResult({this.curPage, this.offset, this.over, this.pageCount, this.size, this.total});

  PageResult.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['curPage'] = this.curPage;
//    if (this.datas != null) {
//      data['datas'] = this.datas.map((v) => v.toJson()).toList();
//    }
//    data['offset'] = this.offset;
//    data['over'] = this.over;
//    data['pageCount'] = this.pageCount;
//    data['size'] = this.size;
//    data['total'] = this.total;
//    return data;
//  }
}
