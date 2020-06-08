

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("网页:", () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });
    tearDown(() {
      print('< Success');
    });
    tearDownAll(() async {
      await driver?.close();
    });
 //   test("网页", () async {
      //   await driver.tap(find.byValueKey("login"));
//      await delayed();
//      await driver.tap(find.byValueKey("phone"));
//      await driver.enterText("18939559565");
//      await delayed();
//      await driver.tap(find.byValueKey("pwd"));
//      await driver.enterText("111111");
//      await delayed();
//      await driver.tap(find.byValueKey("login"));
  //  });
  });
}
