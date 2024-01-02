import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


///EagerGestureRecognizer 急切拿到事件，webview拿到事件
class MyIFrame extends StatefulWidget {
  final String url;
  final Function(double, dynamic)? heightFunc;

  const MyIFrame(this.url, {Key? key, this.heightFunc}) : super(key: key);

  @override
  State<MyIFrame> createState() => _MyIFrameState();
}

class _MyIFrameState extends State<MyIFrame> {
  ValueNotifier<bool> isShowLoading = ValueNotifier(true);
  late WebViewController controller;



  @override
  void dispose() {
    controller.loadRequest(Uri.parse('about:blank'));
    controller.clearCache();
    super.dispose();
  }

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
          gestureRecognizers: {
            if (widget.heightFunc == null)
              Factory(() => EagerGestureRecognizer())
          },
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
