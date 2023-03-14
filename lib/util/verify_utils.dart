import 'package:flutterjdshop/exports.dart';
import 'package:flutterjdshop/util/extension/log_extensions.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
class VerifyUtils {
  static Future<Tuple2<bool, bool>> authenticate(LocalAuthentication auth,
      {bool stickyAuth = false}) async {
    bool authenticated = false;
    bool isError = false;
   final androidStrings =  AndroidAuthMessages(
      cancelButton: '请完成身份验证'
    );
    final iosStrings =  IOSAuthMessages(
        cancelButton: '请完成身份验证'
    );
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        authMessages: [
          androidStrings,
          iosStrings
        ],
        options: AuthenticationOptions(
          stickyAuth: stickyAuth,
        ),
      );
    } on PlatformException catch (e) {
      isError = true;
      'Error - ${e.message}'.log();
    }
    return Tuple2(authenticated, isError);
  }
}
