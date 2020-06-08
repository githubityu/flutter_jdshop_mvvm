import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class RefreshAddressEvent {
}
class ProductContentEvent{
}
class MineChangeEvent{
}
class CheckOutEvent{
}
class OrderInEvent {
  String text;
  OrderInEvent(String text){
    this.text = text;
  }
}
class UserInfoInEvent {
  String text;
  UserInfoInEvent(String text){
    this.text = text;
  }
}
class SpecEvent{
  String  code;
  SpecEvent(String text){
    this.code=text;
  }
}

class TabIndexEvent{
  int num;
  TabIndexEvent(int text){
    this.num=text;
  }
}
