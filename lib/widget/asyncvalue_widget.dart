import 'package:flutterjdshop/exports.dart';
import 'package:flutterjdshop/util/extension/log_extensions.dart';
import 'package:flutter/material.dart';


class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(this.value,
      {Key? key, required this.asyncValueBuilder, this.isShowLoading = true})
      : super(key: key);
  final AsyncValue<T?> value;
  final bool isShowLoading;
  final Widget Function(T? t) asyncValueBuilder;

  @override
  Widget build(BuildContext context) {
    return value.when(
        data: (T? value) => asyncValueBuilder(value),
        error: (error, _) {
          '$error $T'.log();
          return Text(
            '$error $T',
            style: const TextStyle(color: Colors.red),
          );
        },
        loading: () =>
            isShowLoading ? const LoadingWidget() : const SizedBox.shrink());
  }
}


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Center(child: CircularProgressIndicator()));
  }
}