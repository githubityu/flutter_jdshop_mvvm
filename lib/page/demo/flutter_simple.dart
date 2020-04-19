import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/view/app_topbar.dart';

class SimpleDemoPage extends StatefulWidget {
  final Map<String, List<String>> address;

  const SimpleDemoPage({Key key, this.address}) : super(key: key);

  @override
  _SimpleDemoPageState createState() => _SimpleDemoPageState();
}

class _SimpleDemoPageState extends BasePageState<SimpleDemoPage> {
  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "小代码");
  }

  @override
  void subInitState() {}

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return new Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 200,
            height: 50,
            color: Colors.red,
            ///解决超出父容器溢出的问题
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 50,
                    color: Colors.blue,
                    child: Text("============"),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 50,
                  ///设置可以超出父布局的宽度但是父布局必须设置宽度
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 1,
                    child: Container(
                      color: Colors.blue,
                      child: Text("============"),
                    ),
                  ),
                )
              ],
            ),
          ),
          TextField(
            maxLength: 20,
            keyboardType:TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]"))],
            decoration: InputDecoration(
              hintText: "请输入手机号",
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1
                )
              ),
              enabledBorder: UnderlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 10)
            ),
          ),
          TextField(
            maxLength: 20,
            keyboardType:TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [UsNumberTextInputFormatter()],
            decoration: InputDecoration(
                hintText: "请输入小数",
                counterText: "",
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 1
                    )
                ),
                enabledBorder: UnderlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10)
            ),
          ),
          TextField(
            maxLength: 20,
            keyboardType:TextInputType.text,
            inputFormatters: [BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))],
            decoration: InputDecoration(
                hintText: "请输入非中文",
                counterText: "",
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 1
                    )
                ),
                enabledBorder: UnderlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10)
            ),
          ),
          Material(
            color: Colors.white,
            child:   InkWell(
              borderRadius: BorderRadius.circular(8.0), // 圆角
              splashColor: Colors.red, // 溅墨色（波纹色）
              highlightColor: Colors.blue, // 点击时的背景色（高亮色）
              onTap: () {},// 点击事件
              child: Container(
                child: Text("测试点击水波纹"),
              ),
            )
            ,
          ),
          IgnorePointer(
            ignoring:true,
            child: RaisedButton(
              onPressed: (){

              },
              child: Text("测试IgnorePointer"),
            ),
          )

        ],
      ),
    );
  }
}

class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" && value != defaultDouble.toString() && strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}