import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {
  group("登录:", () {
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
    test("登录页面按钮点击", () async {
      //   await driver.tap(find.byValueKey("login"));
//      await delayed();
//      await driver.tap(find.byValueKey("phone"));
//      await driver.enterText("18939559563");
//      await delayed();
//      await driver.tap(find.byValueKey("pwd"));
//      await driver.enterText("111111");
//      await delayed();
//      await driver.tap(find.byValueKey("login"));
    });
  });
}
