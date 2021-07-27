import 'package:flutterjdshop/config/api.dart';
import 'package:flutterjdshop/http/req_model.dart';

class ProductModel2 extends ReqModel {
  int type = 0;

  @override
  String url() => "${API.plist}";

  Map<String, dynamic> params() {
    return {(type == 0 ? "is_hot" : "is_best"): "1"};
  }

  Future data(type) {
    this.type = type;
    return get();
  }
}

class ProductModel {
  List<ProductItemModel>? result;

  ProductModel({this.result});

  ProductModel.fromJson(List<dynamic> json) {
    result = List.empty();
    json.forEach((v) {
      result!.add(new ProductItemModel.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItemModel {
  String? sId;
  String? title;
  String? cid;
  Object? price; //所有的类型都继承 Object
  String? oldPrice;
  String? pic;
  String? sPic;

  ProductItemModel(
      {this.sId,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.pic,
      this.sPic});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['pic'] = this.pic;
    data['s_pic'] = this.sPic;
    return data;
  }
}
