import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 355,
//      "name": 'OutlinedButton样式',
//      "priority": 2,
//      "subtitle":
//          "【style】 : 按钮样式   【ButtonStyle】\n"
//          "【focusNode】 : 焦点   【FocusNode】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【autofocus】 : 自动聚焦   【bool】",
//    }

class OutlinedButtonStyleDemo extends StatelessWidget {
  const OutlinedButtonStyleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 10,
        children: [
          OutlinedButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange,
                elevation: 2,
                shadowColor: Colors.orangeAccent),
            onPressed: _onPressed,
            onLongPress: _onLongPress,
            child: const Text('ElevatedButton样式'),
          ),
          OutlinedButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.blue,width: 1),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                // elevation: 2,
                shadowColor: Colors.orangeAccent),
            autofocus: false,
            onPressed: _onPressed,
            onLongPress: _onLongPress,
            child: const Text('ElevatedButton边线'),
          ),
        ],
      ),
    );
  }

  void _onPressed() {}

  void _onLongPress() {}
}
