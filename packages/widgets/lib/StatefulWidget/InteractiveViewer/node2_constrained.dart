import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 351,
//      "name": "constrained属性测试",
//      "priority": 2,
//      "subtitle": "【constrained】 :  受约束的  【bool】",
//    }

class InteractiveViewerDemo2 extends StatelessWidget {
  const InteractiveViewerDemo2({super.key});

  static const List<Color> colors =  [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];

  static const List<Color> colors2 =  [
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    int rowCount = 20;
    int columnCount = 4;

    return SizedBox(
      width: 300,
      height: 200,
      child: InteractiveViewer(
        constrained: false,
        scaleEnabled: false,
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            for (int column = 0; column < columnCount; column += 1)
              column: const FixedColumnWidth(150.0),
          },
          children: buildRows(rowCount, columnCount),
        ),
      ),
    );
  }

  List<TableRow> buildRows(int rowCount, int columnCount) {
    return <TableRow>[
      for (int row = 0; row < rowCount; row += 1)
        TableRow(
          children: <Widget>[
            for (int column = 0; column < columnCount; column += 1)
              Container(
                margin: const EdgeInsets.all(2),
                height: 50,
                alignment: Alignment.center,
                color: _colorful(row, column),
                child: Text(
                  '($row,$column)',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
          ],
        ),
    ];
  }

  Color _colorful(int row, int column) =>
      row % 2 == 0 ? colors[column] : colors2[column];
}
