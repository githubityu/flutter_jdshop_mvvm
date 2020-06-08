import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/page/demo/share_data_widget.dart';
import 'package:flutterjdshop/view/app_topbar.dart';

class InheritedWidgetPage extends StatefulWidget {
  final Map<String, List<String>> address;

  const InheritedWidgetPage({Key key, this.address}) : super(key: key);

  @override
  _InheritedWidgetPageState createState() => _InheritedWidgetPageState();
}

class _InheritedWidgetPageState extends BasePageState<InheritedWidgetPage> {
  int count = 0;

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "InheritedWidget的使用方法");
  }

  @override
  void subInitState() {

  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return new Center(
      child: new Column(
        children: <Widget>[
          ShareDataWidget(
            data: count,
            child: _TestWidget(),
          ),
          Container(
            color: Colors.red,
            child: new MaterialButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });

                }, child: new Text("测试InheritedWidget")),
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }
}
class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => new __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget
        .of(context)
        .data
        .toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}
