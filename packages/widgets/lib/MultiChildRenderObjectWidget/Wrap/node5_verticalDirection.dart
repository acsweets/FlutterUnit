import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 98,
//      "name": 'Wrap的verticalDirection属性',
//      "priority": 5,
//      "subtitle":
//          "【verticalDirection】 : 竖直方向  【VerticalDirection】",
//    }
class VerticalDirectionWrap extends StatelessWidget {
  VerticalDirectionWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: VerticalDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  final Widget yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final Widget redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final Widget greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final Widget blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final Widget purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final Widget orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final Widget cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  Widget _buildItem(mode) => Wrap(
    verticalDirection: mode,
    direction: Axis.vertical,
    runSpacing: 10,
    spacing: 10,
    children: [
      yellowBox, redBox, greenBox, cyanBox,
      blackBox, purpleBox, orangeBox,
    ],
  );
}