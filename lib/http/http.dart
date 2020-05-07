import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/biz_result.dart';
import 'package:wanandroidflutter/data/home_banner_data.dart';
import 'package:wanandroidflutter/data/home_data_page_result.dart';

class Http {
  static const BASE_URL = 'https://www.wanandroid.com';
  static Dio _dio = Dio();
  static Http _http;

  /// http拦截器
  InterceptorsWrapper _wrapper = InterceptorsWrapper(
    onRequest: (RequestOptions options) async {
      options.headers['Connection'] = 'Keep-Alive';
      options.headers['User-Agent'] = 'flutter';

      options.extra['time'] = DateTime.now();

      print(' ───────────────────────────────────────────────────────────────');
      print('│ --> ${options.method} ${options.uri}');
      options.headers.forEach((k, v) {
        print('│ "$k": $v');
      });

      if (options.data is Map) {
        print('│ {');
        _mapToJsonString(options.data, '');
        print('│ }');
      } else if (options.data is List) {
        _listToJsonString(options.data, '');
      }

      print(' ───────────────────────────────────────────────────────────────');
      return options;
    },
    onResponse: (Response response) async {
      DateTime oldTime = response.request.extra['time'] ?? DateTime.now();
      var time = DateTime.now().millisecond - oldTime.millisecond;
      print(' ───────────────────────────────────────────────────────────────');
      print('│ <-- ${response.statusCode} ${response.request.uri} (${time}ms)');
      response.headers.forEach((k, v) {
        print('│ "$k": $v');
      });

      if (response.data is Map) {
        print('│ {');
        _mapToJsonString(response.data, '');
        print('│ }');
      } else if (response.data is List) {
        _listToJsonString(response.data, '');
      }
      print('│ <-- END HTTP');
      print(' ───────────────────────────────────────────────────────────────');
      return response;
    },
    onError: (DioError error) async {},
  );

  /// json格式化
  static void _mapToJsonString(Map<String, dynamic> map, String space) {
//    print('│ $space{');
    map.forEach((k, v) {
      if (v is Map) {
        print('│ $space"$k": {');
        _mapToJsonString(v, ' $space');
        print('│ $space}');
      } else if (v is List) {
        _listToJsonString(v, ' $space');
      } else if (v is String) {
        print('│  $space"$k": "$v"');
      } else {
        print('│  $space"$k": $v');
      }
    });
//    print('│ $space}');
  }

  /// json格式化
  static void _listToJsonString(List<dynamic> list, String space) {
    if (list.length == 0) {
      print('│ $space[]');
    } else {
      for (int i = 0; i < list.length; i++) {
        var v = list[i];
        if (v is Map) {
          if (i == 0) {
            print('│ $space[{');
          } else {
            print('│ $space{');
          }
          _mapToJsonString(v, ' $space');
          if (i == list.length - 1) {
            print('│ $space}]');
          } else {
            print('│ $space}');
          }
        } else {
          if (i == 0) {
            print('│ $space[');
          }
          if (v is List) {
            _listToJsonString(v, ' $space');
          } else if (v is String) {
            print('│  $space: "$v"');
          } else {
            print('│  $space: $v');
          }
          if (i == list.length - 1) {
            print('│ $space]');
          }
        }
      }
    }
  }

  factory Http() => _sharedInstance();

  static Http _instance;

  Http._() {
    BaseOptions options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 8000,
      receiveTimeout: 8000,
    );

//    _dio.interceptors.add(CookieManager(CookieJar()));
    _dio.options = options;
    _dio.interceptors.add(_wrapper);
  }

  // 静态、同步、私有访问点
  static Http _sharedInstance() {
    if (_instance == null) {
      _instance = Http._();
    }
    return _instance;
  }

  void dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  Future<Response> get(String url) async {
    return await _dio.get(url);
  }

  Future<Response> post(String url, data) async {
    return await _dio.post(url, data: data);
  }

  Future<BizResult<HomeDataPageResult>> getHomeData(int page) async {
    Response response = await get('/article/list/$page/json');
    BizResult<HomeDataPageResult> result = BizResult.fromJson(response.data);
    HomeDataPageResult pageResult = HomeDataPageResult.fromJson(response.data['data']);
    result.data = pageResult;
    return result;
  }

  Future<BizResult<List<HomeBannerData>>> getHomeBannerData() async {
    Response response = await get('/banner/json');
    BizResult<List<HomeBannerData>> result = BizResult.fromJson(response.data);
    List<HomeBannerData> list = List();
    List<dynamic> datas = response.data['data'];
    for (var d in datas) {
      list.add(HomeBannerData.fromJson(d));
    }
    result.data = list;
    return result;
  }
}
