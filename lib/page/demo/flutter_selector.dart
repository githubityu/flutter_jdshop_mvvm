import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/provider/counter_provider.dart';
import 'package:flutterjdshop/utils/log_utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:provider/provider.dart';

import 'customcheckbox/my_check_box.dart';

///我们在使用Selector的时候也小心一些，包裹的粒度尽可能的小
class SelectorPage extends StatefulWidget {
  final Map<String, List<String>> address;

  const SelectorPage({Key key, this.address}) : super(key: key);

  @override
  _SelectorPageState createState() => _SelectorPageState();
}

class _SelectorPageState extends BasePageState<SelectorPage> {
  var check = false;
  var myCheckBoxKey = GlobalKey();

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "Selector的使用方法");
  }

  @override
  void subInitState() {}

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    Log.e("getBody=$check");
    return new Center(
      child: new Column(
        children: <Widget>[
          Checkbox(value: check, onChanged: (value) {}),
          CheckboxListTile(
            secondary: const Icon(Icons.shutter_speed),
            title: const Text('硬件加速'),
            value: this.check,
            onChanged: (bool value) {
              setState(() {
                this.check = value;
                (myCheckBoxKey.currentState as CheckTextBox).isChecked = check;
              });
            },
          ),
          MyCheckBox(
            key: myCheckBoxKey,
            isChecked: check,
            colorBg: Colors.black,
            onChecked: (value) {
              check = value;
              Log.e("$check");
            },
          ),
          new Container(
            child: new MaterialButton(
                onPressed: () {
                  //false
                  Provider.of<CounterProvider>(context, listen: false)
                      .increment();
                  setState(() {
                    Log.e("$check");
                  });
                },
                child: new Text("测试Selector")),
            padding: const EdgeInsets.all(8.0),
          ),
          Selector(builder: (context, value, child) {
            return Text("$value");
          }, selector: (context, CounterProvider value) {
            return value.value;
          })
        ],
      ),
    );
  }
}
