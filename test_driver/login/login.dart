import 'package:flutter/cupertino.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutterjdshop/main.dart';
import 'package:flutterjdshop/page/user/loginregister/login.dart';

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(MyApp(home: LoginPage()));
}
