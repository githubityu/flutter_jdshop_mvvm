class OrderModel {
  bool success;
  String message;
  List<Result> result;

  OrderModel({this.success, this.message, this.result});

  OrderModel.fromJson(List<dynamic> json) {

    if (json!= null) {
      result = new List<Result>();
      json.forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String sId;
  String uid;
  String name;
  String phone;
  String address;
  String allPrice;
  int payStatus;
  int orderStatus;
  List<OrderItem> orderItem;

  Result(
      {this.sId,
      this.uid,
      this.name,
      this.phone,
      this.address,
      this.allPrice,
      this.payStatus,
      this.orderStatus,
      this.orderItem});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    allPrice = json['all_price'];
    payStatus = json['pay_status'];
    orderStatus = json['order_status'];
    if (json['order_item'] != null) {
      orderItem = new List<OrderItem>();
      json['order_item'].forEach((v) {
        orderItem.add(new OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['all_price'] = this.allPrice;
    data['pay_status'] = this.payStatus;
    data['order_status'] = this.orderStatus;
    if (this.orderItem != null) {
      data['order_item'] = this.orderItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItem {
  String sId;
  String orderId;
  String productTitle;
  String productId;
  int productPrice;
  String productImg;
  int productCount;
  String selectedAttr;
  int addTime;

  OrderItem(
      {this.sId,
      this.orderId,
      this.productTitle,
      this.productId,
      this.productPrice,
      this.productImg,
      this.productCount,
      this.selectedAttr,
      this.addTime});

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['order_id'];
    productTitle = json['product_title'];
    productId = json['product_id'];
    productPrice = json['product_price'];
    productImg = json['product_img'];
    productCount = json['product_count'];
    selectedAttr = json['selected_attr'];
    addTime = json['add_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['order_id'] = this.orderId;
    data['product_title'] = this.productTitle;
    data['product_id'] = this.productId;
    data['product_price'] = this.productPrice;
    data['product_img'] = this.productImg;
    data['product_count'] = this.productCount;
    data['selected_attr'] = this.selectedAttr;
    data['add_time'] = this.addTime;
    return data;
  }
}