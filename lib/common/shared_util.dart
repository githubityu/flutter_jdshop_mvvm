import 'dart:convert';

import 'package:flutterjdshop/config/keys.dart';
export 'package:flutterjdshop/config/keys.dart';
import 'package:flutterjdshop/config/storage_manager.dart';

class SharedUtil {
  factory SharedUtil() => _getInstance();

  static SharedUtil get instance => _getInstance();
  static SharedUtil _instance;

  SharedUtil._internal() {
    //初始化
    //init
  }

  static SharedUtil _getInstance() {
    if (_instance == null) {
      _instance = new SharedUtil._internal();
    }
    return _instance;
  }

  /// save
  Future saveString(String key, String value) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    await StorageManager.sp.setString(key + account, value);
  }

  Future saveInt(String key, int value) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    await StorageManager.sp.setInt(key + account, value);
  }

  Future saveDouble(String key, double value) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    await StorageManager.sp.setDouble(key + account, value);
  }

  Future saveBoolean(String key, bool value) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    await StorageManager.sp.setBool(key + account, value);
  }

  Future saveStringList(String key, List<String> list) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    await StorageManager.sp.setStringList(key + account, list);
  }

  Future<bool> readAndSaveList(String key, String data) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    List<String> strings = StorageManager.sp.getStringList(key + account) ?? [];
    if (strings.length >= 10) return false;
    strings.add(data);
    await StorageManager.sp.setStringList(key + account, strings);
    return true;
  }

  void readAndExchangeList(String key, String data, int index) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    List<String> strings = StorageManager.sp.getStringList(key + account) ?? [];
    strings[index] = data;
    await StorageManager.sp.setStringList(key + account, strings);
  }

  void readAndRemoveList(String key, int index) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    List<String> strings = StorageManager.sp.getStringList(key + account) ?? [];
    strings.removeAt(index);
    await StorageManager.sp.setStringList(key + account, strings);
  }

  /// get
  String getString(String key) {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    return StorageManager.sp.getString(key + account);
  }

  int getInt(String key) {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    return StorageManager.sp.getInt(key + account);
  }

  double getDouble(String key) {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    return StorageManager.sp.getDouble(key + account);
  }

  bool getBoolean(String key, {defValue = false}) {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    return StorageManager.sp.getBool(key + account) ?? defValue;
  }

  List<String> getStringList(String key) {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    return StorageManager.sp.getStringList(key + account);
  }

  T getAny<T>(String key) {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    return json.decode(StorageManager.sp.getString(key + account));
  }

  Future saveAny<T>(String key, T data) async {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    await StorageManager.sp.setString(key + account, json.encode(data));
  }

  List<String> readList(String key) {
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    List<String> strings = StorageManager.sp.getStringList(key + account) ?? [];
    return strings;
  }

  Future remove(String key) async{
    String account = StorageManager.sp.getString(Keys.account) ?? "default";
    await StorageManager.sp.remove(key+account);
  }
}
