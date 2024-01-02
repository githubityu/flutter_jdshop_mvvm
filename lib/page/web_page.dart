import 'package:flutter/material.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/view/customize_appbar.dart';
import 'package:flutterjdshop/widget/my_iframe/my_iframe.dart';


class WebViewPage extends StatefulWidget {
  const WebViewPage({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String? title;
  final String? url;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child:
            CommonBackTopBar(title: widget.title),
      ),
      body: Stack(
        children: <Widget>[
          MyIFrame(
             widget.url!),
          _loading()
        ],
      ),
    );
  }

  _loading() {
    return _isLoading == true
        ? Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Text('');
  }
}
