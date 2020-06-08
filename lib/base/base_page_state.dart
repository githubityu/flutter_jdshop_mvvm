import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/http/mvvms.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/dialog_utils.dart';
import 'package:flutterjdshop/utils/log_utils.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/view/custom_view.dart';
import 'package:flutterjdshop/view/customize_appbar.dart';


///  如果withAutomaticKeepAliveClientMixin 就必须要重写build(BuildContext context)方法

abstract class BasePageState<T extends StatefulWidget> extends State<T>
    implements IMvvmView {
  CancelToken _cancelToken;

  BasePageState() {
    _cancelToken = CancelToken();
    injectViewModelView();
  }

  @override
  void initState() {
    Log.e("initState");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      subInitState();
    });
  }

  void subInitState() {}

  @override
  Widget build(BuildContext context) {
    Log.e("build");
    AppSize.init(context);
    return getScaffold();
  }

  ///方便width AutomaticKeepAliveClientMixin的使用
  Widget getScaffold() {
    return Scaffold(
      appBar: useMyAppBar() ? MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(80)),
          child: getAppBar(context)) : getAppBar(context),
      body: isAutoCloseKeyboard()
          ? hideKeyword(getBody(context), context)
          : getBody(context),
    );
  }


  BuildContext getContext() {
    return context;
  }

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  bool _isShowDialog = false;

  @override
  void showProgress() {
    /// 避免重复弹出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async {
                  // 拦截到返回键，证明dialog被手动关闭
                  _isShowDialog = false;
                  return Future.value(true);
                },
                child: const LoadingDialog(
                  text: "加载中…",
                ),
              );
            });
      } catch (e) {
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  void showToast(String string) {
    DialogUtil.buildToast(string);
  }

  @override
  void didChangeDependencies() {
    Log.e("didChangeDependencies");
    super.didChangeDependencies();
  }

  bool useMyAppBar() => true;

  bool isAutoCloseKeyboard() => true;

  @override
  void dispose() {
    Log.e("dispose");
    super.dispose();
    if (_cancelToken != null && !_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  @override
  void deactivate() {
    Log.e("deactivate");
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    Log.e("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  void didUpdateWidgets<W>(W oldWidget) {}

  CancelToken getCancelToken() {
    return _cancelToken;
  }

  Widget getAppBar(BuildContext context) {
    return null;
  }

  Widget getBody(BuildContext context);

  //如果要用model与view交互就需要给viewmodle 设置view
  void injectViewModelView() {}
}
