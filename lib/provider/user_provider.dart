
import 'package:flutter/material.dart';
import 'package:flutterjdshop/config/user_info_data.dart';


class UserProvider extends ChangeNotifier {

  UserInfoData _user;
  UserInfoData get user => _user;
  
  void setUser(UserInfoData user) {
    _user = user;
    notifyListeners();
  }
}