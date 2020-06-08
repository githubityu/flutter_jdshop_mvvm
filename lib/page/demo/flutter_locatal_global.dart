import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/utils/image_utils.dart';
import 'package:flutterjdshop/utils/log_utils.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/view/popup_window.dart';
import 'package:provider/provider.dart';
import 'package:flutterjdshop/provider/counter_provider.dart';

///全局坐标相对于整个屏幕的
///局部坐标相对于父widget
class LocalToGlobalPage extends StatefulWidget {
  final Map<String, List<String>> address;

  const LocalToGlobalPage({Key key, this.address}) : super(key: key);

  @override
  _LocalToGlobalPageState createState() => _LocalToGlobalPageState();
}

class _LocalToGlobalPageState extends BasePageState<LocalToGlobalPage> {
  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "localToGlobal的使用方法");
  }

  @override
  void subInitState() {}

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return new Center(
      child: new Column(
        children: <Widget>[
          GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details){
              RenderBox findRenderObject = _testKey.currentContext.findRenderObject();
              var dx = findRenderObject.globalToLocal(details.globalPosition).dx;
              Log.e("${details.globalPosition.dx}=$dx");
            },
            child: Container(
              key: _testKey,
              color: Colors.blue,
              width: 200,
              height: 40,
            ),
          ),
          new Container(
            color: Colors.red,
            key: _hintKey,
            child: new MaterialButton(
                onPressed: () {
                  _showHint();
                },
                child: new Text("测试localToGlobal")),
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }

  final GlobalKey _hintKey = GlobalKey();
  final GlobalKey _testKey = GlobalKey();

  /// design/4商品/index.html#artboard18
  void _showHint() {
    final RenderBox hint = _hintKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var dy = hint.localToGlobal(Offset.zero).dy;
    var dx = hint.localToGlobal(Offset.zero).dx;
    var dy2 = overlay.localToGlobal(Offset.zero).dy;
    var dx2 = overlay.localToGlobal(Offset.zero).dx;
    var a = hint.localToGlobal(Offset(50.0, hint.size.height + 150.0),
        ancestor: overlay);
    var b = hint.localToGlobal(hint.size.bottomLeft(Offset(50.0, 150.0)),
        ancestor: overlay);
    var dy3 = a.dy;
    var dx3 = a.dx;
    var dy4 = b.dy;
    var dx4 = b.dx;
    Log.e("$dy=$dy2=$dy3=$dy4");
    Log.e("$dx=$dx2=$dx3=$dx4");
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    showPopupWindow(
        context: context,
        fullWidth: false,
        isShowBg: true,
        position: position,
        elevation: 0.0,
        child: Semantics(
          label: '弹出引导页',
          hint: '向左滑动可删除列表，点击可关闭',
          button: true,
          child: Container(
            key: const Key('hint'),
            width: 200.0,
            height: 147.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ImageUtils.getAssetImage('ydss'),
                    fit: BoxFit.fitWidth)),
          ),
        ));
  }
}
