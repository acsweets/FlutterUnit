import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 75,
//      "name": 'Baseline基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【baseline】 : 基线位置   【double】\n"
//          "【baselineType】 : 基线类型   【TextBaseline】",
//    }
class CustomBaseline extends StatefulWidget {
  const CustomBaseline({super.key});

  @override
  _CustomBaselineState createState() => _CustomBaselineState();
}

class _CustomBaselineState extends State<CustomBaseline> {
  double _baseline=20;

  @override
  Widget build(BuildContext context) {
    Widget childBox = const Text(
      '你好,Flutter',
      style: TextStyle(fontSize: 20, fontFamily: "Menlo"),
    );


    Widget baseline = Baseline(
        baseline: _baseline,
        baselineType: TextBaseline.alphabetic,
        child: childBox);

    return Column(
      children: <Widget>[
        _buildSlider(),
        Container(
          width: 100/0.618,
          height: 100,
          color: Colors.grey.withAlpha(22),
          child: baseline,
        ),
      ],
    );
  }

  Widget _buildSlider() => Slider(
        divisions: 20,
        min: 0,
        max: 60,
        label: _baseline.toString(),
        value: _baseline,
        onChanged: (v) => setState(() => _baseline = v),
      );
}
