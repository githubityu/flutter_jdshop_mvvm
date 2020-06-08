import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/view/app_topbar.dart';

class OverlayPage extends StatefulWidget {
  final Map<String, List<String>> address;

  const OverlayPage({Key key, this.address}) : super(key: key);

  @override
  _OverlayPageState createState() => _OverlayPageState();
}

class _OverlayPageState extends BasePageState<OverlayPage> {
  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "Overlay的使用方法");
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
            child: new MaterialButton(
                onPressed: () {
                  showWx();
                },
                child: new Text("测试Overlay")),
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }

//  Widget showToast2() {
//    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
//      return Container(
//        alignment: Alignment.center,
//        child: Text("测试"),
//      );
//    });
//    Overlay.of(context).insert(overlayEntry);
//    Future.delayed(Duration(seconds: 2), () {
//      overlayEntry.remove();
//    });
//  }
  OverlayEntry _weixinOverlayEntry;
  OverlayState _overlayState;
  bool _isVisible = false;

  /// 展示微信下拉的弹窗
  OverlayEntry createWeixinButtonView() {
    return new OverlayEntry(builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          hideWx();
        },
        child: Stack(
          children: <Widget>[
            Positioned(
                top: kToolbarHeight,
                right: 20,
                width: 200,
                height: 320,
                child: new SafeArea(
                    child: new Material(
                  child: new Container(
                    color: Colors.black,
                    child: new Column(
                      children: <Widget>[
                        Expanded(
                          child: new ListTile(
                            onTap: () {
                              showToast("=====");
                              hideWx();
                            },
                            leading: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            title: new Text(
                              "发起群聊",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: new ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            title: new Text("添加朋友",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Expanded(
                          child: new ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            title: new Text("扫一扫",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Expanded(
                          child: new ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            title: new Text("首付款",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Expanded(
                          child: new ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            title: new Text("帮助与反馈",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )))
          ],
        ),
      );
    });
  }

  showWx() async {
    if (!_isVisible) {
      _overlayState = Overlay.of(context);
      _weixinOverlayEntry = createWeixinButtonView();
      _overlayState.insert(_weixinOverlayEntry);
      _isVisible = true;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    hideWx();
    super.dispose();
  }

  void hideWx() {
    _isVisible = false;
    _weixinOverlayEntry?.remove();
  }
}
