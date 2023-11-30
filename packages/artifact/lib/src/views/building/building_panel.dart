import 'package:flutter/material.dart';

class BuildingPanel extends StatelessWidget {
  const BuildingPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_chart,size: 36,color: Colors.grey,),
          SizedBox(height: 8,),
          Text('正在建设中',style: TextStyle(color: Colors.grey),),
        ],
      ),
    );
  }
}
