import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/page/demo/my_custompainter.dart';
import 'package:flutterjdshop/view/app_topbar.dart';

import 'my_custompainter2.dart';
import 'path_custompainter.dart';

class PathStudy extends StatefulWidget {
  @override
  _PathStudyState createState() => _PathStudyState();
}

class _PathStudyState extends BasePageState<PathStudy> {
  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "Path学习");
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      child: Column(
        children: <Widget>[
          RepaintBoundary(
            child: CustomPaint(
              size: Size(300, 300),
              painter: PathPainterStudy(),
            ),
          ),
        ],
      ),
    );
  }
}
