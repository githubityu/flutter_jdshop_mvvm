import 'package:flutterjdshop/util/extension/log_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyIFrame extends StatefulWidget {
  final String url;
  final Function(double, WebViewController)? heightFunc;

  const MyIFrame(this.url, {Key? key, this.heightFunc}) : super(key: key);

  @override
  State<MyIFrame> createState() => _MyIFrameState();
}

class _MyIFrameState extends State<MyIFrame> {
  ValueNotifier<bool> isShowLoading = ValueNotifier(true);
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    //gestureNavigationEnabled
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              isShowLoading.value = false;
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            controller
                .runJavaScriptReturningResult('document.body.scrollHeight')
                .then((value) {
              value.log('height');
              widget.heightFunc?.call(double.parse('$value'), controller);
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
          controller: controller,
        ),
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
