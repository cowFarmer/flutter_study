import 'package:air_pollution/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'TestScreen',
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('key = ${box.keys.toList()}');
              print('value = ${box.values.toList()}');
            },
            child: Text(
              '박스 프린트하기!',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // 데이터 넣기
              // box.add('테스트');
              // key value 값 넣기
              // box.put(2, '테스트999');
              // bool값 넣기
              box.put(101, true);
            },
            child: Text(
              '데이터 넣기',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              print(box.get(101));
            },
            child: Text(
              '특정 값 가져오기',
            ),
          ),
        ],
      ),
    );
  }
}
