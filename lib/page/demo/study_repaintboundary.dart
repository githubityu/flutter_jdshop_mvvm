import 'package:flutter/material.dart';
import 'package:flutterjdshop/page/demo/boundary.dart';

class StudyBoundary extends StatefulWidget {
  @override
  _StudyBoundaryState createState() => _StudyBoundaryState();
}

class _StudyBoundaryState extends State<StudyBoundary> {
  String _buttonText = 'test';
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ddddd"),
        ),
        body: Container(
          child: CustomMultiChildLayout(
              delegate: LayoutBoundaryDelegate(),
              children: <Widget>[
                LayoutId(
                    id: LayoutBoundaryDelegate.title,
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Container(
                        height: 50.0, // add for test relayoutBoundary
                        child: LayoutBoundary(),
                      )),
                      Expanded(
                          child: Text(
                              'You have pushed the button this many times:'))
                    ])),
                LayoutId(
                    id: LayoutBoundaryDelegate.summary,
                    child: Container(
                      width: 200.0, // add for test relayoutBoundary
                      height: 50.0, // add for test relayoutBoundary
                      child: InkWell(
                        child: Text(
                          _buttonText,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        onTap: () {
                          setState(() {
                            _index++;
                            _buttonText = 'onTap$_index';
                          });
                        },
                      ),
                    )),
                LayoutId(
                    id: LayoutBoundaryDelegate.paintBoundary,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: RepaintBoundary(
                        // add for test repaintBoundary
                        child: PaintBoundary(),
                      ),
                    )),
              ]),
        ));
  }
}
