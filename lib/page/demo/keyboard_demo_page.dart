import 'package:flutter/material.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/widget/view/keyboard_detector.dart';

///键盘相关Demo
///键盘是否弹起等
class KeyBoardDemoPage extends StatefulWidget {
  @override
  _KeyBoardDemoPageState createState() => _KeyBoardDemoPageState();
}

class _KeyBoardDemoPageState extends State<KeyBoardDemoPage> {
  bool isKeyboardShowing = false;

  final FocusNode _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    ///必须嵌套在外层
    return KeyboardDetector(
      Scaffold(
        appBar: AppBar(
          title: new Text("KeyBoardDemoPage"),
        ),
        body: new GestureDetector(
          ///透明可以触摸
          behavior: HitTestBehavior.translucent,
          onTap: () {
            /// 触摸收起键盘
            hideKeyword2(context);
          },
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    alignment: Alignment.center,
                    child: Text(
                      isKeyboardShowing ? "键盘弹起" : "键盘未弹起",
                      style: TextStyle(
                          color: isKeyboardShowing
                              ? Colors.redAccent
                              : Colors.greenAccent),
                    ),
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child: new Center(
                    child: new FlatButton(
                      onPressed: () {
                        if (!isKeyboardShowing) {
                          /// 触摸收起键盘
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: new Text("弹出键盘"),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: new TextField(
                      focusNode: _focusNode,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      keyboardShowCallback: (isKeyboardShowing) {
        ///当前键盘是否可见
        setState(() {
          this.isKeyboardShowing = isKeyboardShowing;
        });
      },

    );
  }
}