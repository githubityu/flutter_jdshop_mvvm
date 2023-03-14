
import 'package:flutter/material.dart';
import 'package:flutterjdshop/exports.dart';
import 'package:flutterjdshop/util/extension/object_ext.dart';
import 'package:flutterjdshop/widget/export_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final preBackpress = useRef(DateTime.now());
    final duration = useRef(const Duration(seconds: 2));

    return WillPopScope(
      onWillPop: () async {
        final timeGap = DateTime.now().difference(preBackpress.value);
        final cantExit = timeGap >= duration.value;
        preBackpress.value = DateTime.now();
        if (cantExit) {
          //Utils.showToast('${context.L?.press_again_exit}');
          return false; // false will do nothing when back press
        } else {
          return true; // true will exit the app
        }
      },
      child: Scaffold(
        body: Container(
          color: Colors.red,
        ),
      ),
    );
  }

}
