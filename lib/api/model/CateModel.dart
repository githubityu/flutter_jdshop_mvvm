import 'package:flutterjdshop/config/api.dart';
import 'package:flutterjdshop/http/req_model.dart';

class CateModel2 extends ReqModel {
  int type = 0;
  String pid;

  @override
  String url() => "${API.pcate}";

  Map<String, dynamic> params() {
    return type == 1 ? {"pid": "$pid"} : {};
  }

  Future data(pid, type) {
    this.type = type;
    this.pid = pid;
    return get();
  }
}

class CateModel {
  List<CateItemModel> result;

  CateModel({this.result});

  CateModel.fromJson(List<dynamic> json) {
    result = new List<CateItemModel>();
    json.forEach((v) {
      result.add(new CateItemModel.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CateItemModel {
  String sId;
  String title;
  Object status;
  String pic;
  String pid;
  String sort;

  CateItemModel(
      {this.sId, this.title, this.status, this.pic, this.pid, this.sort});

  CateItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['pid'] = this.pid;
    data['sort'] = this.sort;
    return data;
  }
}
