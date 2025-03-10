import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 94,
//      "name": 'Flex交叉轴对齐方式',
//      "priority": 3,
//      "subtitle":
//          "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】",
//    }
class CrossAxisAlignmentFlex extends StatelessWidget {
  CrossAxisAlignmentFlex({super.key});

  static TextStyle textStyle =
  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  final Widget blueBox = Container(
    alignment: Alignment.center,
    color: Colors.blue,
    height: 20,
    width: 30,
    child: Text(
      '1',
      style: textStyle
    ),
  );

  final Widget redBox = Container(
    alignment: Alignment.center,
    color: Colors.red,
    height: 30,
    width: 40,
    child: Text(
      '2',
      style: textStyle
    ),
  );

  final Widget greenBox = Container(
    alignment: Alignment.center,
    color: Colors.green,
    height: 20,
    width: 20,
    child: Text(
      '3',
      style: textStyle
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 5,
        children: CrossAxisAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  Widget _buildItem(mode) => Flex(
    direction: Axis.horizontal,
    crossAxisAlignment: mode,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}