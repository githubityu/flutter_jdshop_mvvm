import 'package:flutterjdshop/common/common.dart';
import 'package:flutterjdshop/utils/utils.dart';

class UserInfoData {
  //用户相关信息
  static UserInfoData _instance;
  bool isUser = false;
  int orderIndex = 0;
  String account;
  String salt;
  String id;
  String mobile;
  String token;
  String nickName;
  String avatar;
  String gender;

  factory UserInfoData() => _getInstance();

  static UserInfoData get instance => _getInstance();

  UserInfoData._internal() {
    // 初始化
  }

  static UserInfoData _getInstance() {
    if (_instance == null) {
      _instance = new UserInfoData._internal();
    }
    return _instance;
  }

  setSalt(salt) {
    this.salt = salt;
    saveStrByKey("salt", salt);
  }

  setId(id) {
    this.id = id;
    saveStrByKey("id", id);
  }

  setToken(token) {
    this.token = token;
    saveStrByKey("token", token);
  }

  get isLogin {
    return account != null && account.isNotEmpty;
  }

  setNickName(String name) {
    this.nickName = name;
    saveStrByKey("nickName", name);
  }

  setAvatar(String avatar) {
    this.avatar = avatar;
    saveStrByKey("avatar", avatar);
  }

  setMobile(String mobile) {
    this.mobile = mobile;
    saveStrByKey("mobile", mobile);
  }

  setAccount(String account) {
    this.account = account;
    saveStrByKey("account", account);
  }

  setGender(String gender) {
    this.gender = gender;
    saveStrByKey("gender", gender);
  }

  get getUserInfo {
    this.account = getStrByKey("account");
    this.token = getStrByKey("token");
    this.nickName = getStrByKey("nickName");
    this.salt = getStrByKey("salt");
    this.gender = getStrByKey("gender");
    this.id = getStrByKey("id");
    this.mobile = getStrByKey("mobile");
    this.id = getStrByKey("id");
    this.avatar = getStrByKey("avatar");
  }

  set userInfo(map) {
    setId(map["_id"]);
    setAccount(map["username"]);
    setMobile(map["tel"]);
    setSalt(map["salt"]);
  }
}
