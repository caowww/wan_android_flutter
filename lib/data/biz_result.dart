


/// Create Time 2020/4/25
/// @author caow
class BizResult<T> {
  T data;
  int errorCode;
  String errorMsg;

  BizResult({this.data, this.errorCode, this.errorMsg});

  BizResult.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    data['errorCode'] = this.errorCode;
//    data['errorMsg'] = this.errorMsg;
//    return data;
//  }
}