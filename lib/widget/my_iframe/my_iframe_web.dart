import 'dart:html';
import 'dart:ui' as ui;


import 'package:flutterjdshop/util/extension/log_extensions.dart';
import 'package:flutter/material.dart';

class MyIFrame extends StatefulWidget {
  final String url;
  const MyIFrame(this.url,{Key? key}) : super(key: key);

  @override
  State<MyIFrame> createState() => _MyIFrameState();
}

class _MyIFrameState extends State<MyIFrame> {
  final element = IFrameElement();
  @override
  void initState() {
    super.initState();
    element.src = widget.url;
    element.style.border = "0px solid red";
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'my-iframe-view${widget.url}',
      (int viewId) => element,
    );
    widget.url.log('MyIFrame');
  }

  @override
  void didUpdateWidget(covariant MyIFrame oldWidget) {
    element.src = widget.url;
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return   LimitedBox(
      maxWidth: 300,
      maxHeight: 500,
      child: HtmlElementView(viewType: 'my-iframe-view${widget.url}',),
    );
  }
}
