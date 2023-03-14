import 'package:hive_flutter/hive_flutter.dart';

const boxName = 'app';
const systemConfigBoxName = 'system_config';
const walletBoxName = 'wallet';
const pinCodeTemporary = 'pin_code_temporary';

void putString(String key, String value, {String defaultBoxName = boxName}) {
  Hive.box(defaultBoxName).put(key, value);
}

String getString(String key,
    {String defaultValue = '', String defaultBoxName = boxName}) {
  final result = Hive.box(defaultBoxName).get(key, defaultValue: defaultValue);
  return result;
}

void putBool(String key, bool value, {String defaultBoxName = boxName}) {
  Hive.box(defaultBoxName).put(key, value);
}

bool getBool(String key, {String defaultBoxName = boxName}) {
  return Hive.box(defaultBoxName).get(key, defaultValue: false);
}

void putInt(String key, int value, {String defaultBoxName = boxName}) {
  Hive.box(defaultBoxName).put(key, value);
}

int getInt(String key,
    {int defaultValue = 0, String defaultBoxName = boxName}) {
  return Hive.box(defaultBoxName).get(key, defaultValue: defaultValue);
}

Box getBoxByName({String? name}) {
  return Hive.box(name ?? systemConfigBoxName);
}

void putArray(List items, String key) {
  Hive.box(boxName).put(key, items);
}

List<T> getArray<T>(String key) {
  return Hive.box(boxName).get(key) ?? <T>[];
}

Future<void> deleteItem(String key, int index) {
  return Hive.box(key).delete(index);
}

Future<int> clearArray(String key) {
  return Hive.box(key).clear();
}

Future<void> initLocalData() async {
  await Hive.initFlutter();
  await Hive.openBox(boxName);
  await Hive.openBox(systemConfigBoxName);
}
