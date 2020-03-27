///返回对象封装
class BaseResponse {
  BaseResponse(this.result);


  //返回的数据，需要自己进行处理成自己想要的对象
  dynamic result;
  bool success;
  String message;

  BaseResponse.fromJson(Map<String, dynamic> json)
      :result = json["result"],success=json["success"],message=json["message"];
}