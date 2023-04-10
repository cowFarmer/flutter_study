import 'package:air_pollution/main.dart';
import 'package:air_pollution/screen/test2_screen.dart';
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
          // steambuilder와 동일하게 실시간으로 build 해줌
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box(testBox).listenable(),
            builder: (context, box, widget) {
              return Column(
                children: box.values
                    .map(
                      (e) => Text(e.toString()),
                    )
                    .toList(),
              );
            },
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

              // NoSQL
              // 데이터 넣기
              box.add('테스트');
              // key value 값 넣기
              // box.put(2, '테스트999');
              // bool값 넣기
              // box.put(101, true);
              // map 넣기
              // box.put(102, {'test': 'test5'},);
              // list 넣기
              // box.put(
              //   103,
              //   ['test', 'test5'],
              // );
            },
            child: Text(
              '데이터 넣기',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // Key 값으로 가져오기
              // print(box.get(101));
              // 특정 순서 가져오기
              print(box.getAt(5));
            },
            child: Text(
              '특정 값 가져오기',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // box.delete(3);
              box.deleteAt(0);
            },
            child: Text(
              '삭제하기',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Test2Screen(),
                ),
              );
            },
            child: Text(
              '다음 화면',
            ),
          ),
        ],
      ),
    );
  }
}
