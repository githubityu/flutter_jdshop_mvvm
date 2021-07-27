import 'package:flutter/material.dart';

import 'page_state.dart';




class Tab1Page extends StatefulWidget {
  final TabName tabName;

  const Tab1Page(this.tabName, {Key? key}) : super(key: key);

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey<String>(widget.tabName.toString()),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(index.toString()),
        );
      },
      itemCount: 100,
    );
  }
}
