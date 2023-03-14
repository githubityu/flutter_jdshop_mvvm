import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///带有NestedScrollView下来刷新没有加载更多，需要配合loadMore使用
class RefreshNestedWidget extends HookWidget {
  const RefreshNestedWidget(
      {required this.child,
      Key? key,
      required this.headerSliver,
      this.onRefresh})
      : super(key: key);
  final NestedScrollViewHeaderSliversBuilder headerSliver;
  final Widget child;
  final RefreshCallback? onRefresh;


  @override
  Widget build(BuildContext context) {
    Widget current = child;
    current = NestedScrollView(
      headerSliverBuilder: headerSliver,
      body: child,
    );
    if (onRefresh != null) {
      current = RefreshIndicator(
        onRefresh: onRefresh!,
        child: current,
        notificationPredicate: (ScrollNotification notification) {
          if (notification.metrics.minScrollExtent == 0) {
            return true;
          } else {
            return false;
          }
        },
      );
    }
    return current;
  }
}
