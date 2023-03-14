
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterjdshop/hook/use_router.dart';
import 'package:flutterjdshop/local/screens.dart';
import 'package:flutterjdshop/route/app_router_new.dart';
import 'package:local_auth/local_auth.dart';



class SplashPage extends HookWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = useRef(LocalAuthentication());
    useEffect(() {
      Future.delayed(const Duration(seconds: 2)).then((value) async {
        userAppRouter().go(RoutePath.homePage);
      });
    }, []);
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 1,
            child: Container(
              color: Colors.red,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: Screens.navigationBarHeight,
            child: Center(child: FlutterLogo()),
          ),
        ],
      ),
    );
  }
}
