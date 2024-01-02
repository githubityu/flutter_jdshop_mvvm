import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

// class MyIFrame extends StatefulWidget {
//   final String url;
//   final Function(double, dynamic)? heightFunc;
//
//   const MyIFrame(this.url, {Key? key, this.heightFunc}) : super(key: key);
//
//   @override
//   State<MyIFrame> createState() => _MyIFrameState();
// }
//
// class _MyIFrameState extends State<MyIFrame> {
//   final element = IFrameElement();
//
//   @override
//   void initState() {
//     super.initState();
//     element.src = widget.url;
//     element.style.border = "0px solid red";
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'my-iframe-view${widget.url}',
//       (int viewId) => element,
//     );
//   }
//
//   @override
//   void didUpdateWidget(covariant MyIFrame oldWidget) {
//     element.src = widget.url;
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LimitedBox(
//       maxWidth: 300,
//       maxHeight: 500,
//       child: HtmlElementView(
//         viewType: 'my-iframe-view${widget.url}',
//       ),
//     );
//   }
// }

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

class MyIFrame extends StatefulWidget {
  final String url;
  final Function(double, dynamic)? heightFunc;

  const MyIFrame(this.url, {Key? key, this.heightFunc}) : super(key: key);

  @override
  State<MyIFrame> createState() => _MyIFrameState();
}

class _MyIFrameState extends State<MyIFrame> {
  ValueNotifier<bool> isShowLoading = ValueNotifier(true);
  late final PlatformWebViewController _controller = PlatformWebViewController(
    const PlatformWebViewControllerCreationParams(),
  )..loadRequest(
      LoadRequestParams(
        uri: Uri.parse(widget.url),
      ),
    );

  @override
  void didUpdateWidget(covariant MyIFrame oldWidget) {
    if (widget.url != oldWidget.url) {
      _controller.loadRequest(LoadRequestParams(
        uri: Uri.parse(widget.url),
      ));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlatformWebViewWidget(
          PlatformWebViewWidgetCreationParams(controller: _controller),
        ).build(context),
        ValueListenableBuilder(
          valueListenable: isShowLoading,
          builder: (BuildContext context, bool value, Widget? child) {
            return isShowLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
