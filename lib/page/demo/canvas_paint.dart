import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/page/demo/my_custompainter.dart';
import 'package:flutterjdshop/view/app_topbar.dart';

import 'my_custompainter2.dart';

class CanvasPaintStudy extends StatefulWidget {
  @override
  _CanvasPaintStudyState createState() => _CanvasPaintStudyState();
}

class _CanvasPaintStudyState extends BasePageState<CanvasPaintStudy> {

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(
        title: "学习画布操作"
    );
  }
  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      child: Column(
        children: <Widget>[
          RepaintBoundary(
            child: CustomPaint(
              size: Size(300,300),
              painter: MyCustomPainter(),
            ),
          ),
          RepaintBoundary(
            child: CustomPaint(
              size: Size(300,300),
              painter: MyCustomPainter2(),
            ),
          )
        ],
      ),
    );
  }
}
