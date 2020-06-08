import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
class BracodePage extends StatefulWidget {
  final Map<String, List<String>> address;

  const BracodePage({Key key, this.address}) : super(key: key);

  @override
  _BracodePageState createState() => _BracodePageState();
}

class _BracodePageState extends BasePageState<BracodePage> {
  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "Barcode Scanner Example");
  }

  @override
  void subInitState() {}

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return new Center(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new MaterialButton(onPressed: scan, child: new Text("Scan")),
            padding: const EdgeInsets.all(8.0),
          ),
          new Text(barcode),
        ],
      ),
    );
  }

  String barcode = "";

  Future scan() async {
//    try {
//      ScanResult barcode = await BarcodeScanner.scan();
//      setState(() => this.barcode = barcode.rawContent);
//    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.cameraAccessDenied) {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() => this.barcode = 'Unknown error: $e');
//      }
//    } on FormatException{
//      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
  }


  Future<String> loadString() async {
    final ByteData data = null;
    if (data.lengthInBytes < 10 * 1024) {
      return utf8.decode(data.buffer.asUint8List());
    }
    return compute(_utf8decode, data, debugLabel: "");
  }

  static String _utf8decode(ByteData data) {
    return utf8.decode(data.buffer.asUint8List());
  }

}
