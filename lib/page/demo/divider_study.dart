import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

///height：是控件的高，并不是线的高度，绘制的线居中。
///thickness：线的高度。
///indent：分割线前面空白区域。
///endIndent：分割线后面空白区域。
///可以在ThemeData-dividerTheme中配置 DividerThemeData
class StudyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("====$index"),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.red,
                      endIndent: 10,
                      indent: 5,
                      height: 15,
                    );
                  },
                  itemCount: 3),
            ),
            Column(
              children: ListTile.divideTiles(context: context, tiles: gets())
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> gets() {
    List<Widget> datas = [];
    for(int i=0;i<4;i++){
      datas.add(ListTile(
        title: Text("====$i"),
      ));
    }


    return datas;
  }
}
