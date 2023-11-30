import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 354 ElevatedButton Material风格的升起按钮，表现和RaisedButton类似。可通过样式更改边框、颜色、阴影等属性。
//    {
//      "widgetId": 354,
//      "name": 'ElevatedButton基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 是否具有滚动主体   【Widget】\n"
//          "【onPressed】 : 点击事件   【VoidCallback】\n"
//          "【onLongPress】 : 长按事件   【VoidCallback】",
//    }

class ElevatedButtonDemo extends StatelessWidget {
  const ElevatedButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 60,
        child: Wrap(
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: _onPressed,
              onLongPress: _onLongPress,
              child: const Text('ElevatedButton'),
            ),
            const ElevatedButton(
              onPressed: null,
              onLongPress: null,
              child: Text('禁用按钮'),
            ),
          ],
        ));
  }

  void _onPressed() {}

  void _onLongPress() {}
}
