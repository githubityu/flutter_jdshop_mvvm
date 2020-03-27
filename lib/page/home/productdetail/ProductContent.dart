import 'package:flutter/material.dart';

class ProductContent extends StatefulWidget {
  final String title;
  final int index;

  ProductContent(this.title, this.index, {Key key}) : super(key: key);

  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent>
    with AutomaticKeepAliveClientMixin<ProductContent> {

  bool get wantKeepAlive => true;
  PageStorageKey pKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pKey = PageStorageKey(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Builder(
      builder: (context) {
        return CustomScrollView(
            key: pKey,
            slivers: <Widget>[
              SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      (_, index) => Container(
                          child: Text(
                              '${widget.title} ${widget.index}- ProductContent-item${index + 1}',
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.red)),
                          alignment: Alignment.center),
                      childCount: 15),
                  itemExtent: 80.0)
            ]);
      },
    );
  }
}
