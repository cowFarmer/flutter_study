// make custom widget
import 'dart:js_util';

import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          home: MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var total = 3;
  var name_list = ['이기영', '이기철', '땡구'];

  // 자식 class에서 수정할 수 있게 함수 추가하기
  addOne(){
    setState(() {
      total++;
    });
  }

  nameListAppend(name){
    setState(() {
      name_list.add(name);
    });
    print(name_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return DialogUI(addOne: addOne, nameListAppend: nameListAppend);
          });
        },
      ),
      appBar: AppBar(title: Text(total.toString()),),
      body: ListView.builder(
        itemCount: name_list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.account_circle_rounded, size: 45,),
            title: Text(name_list[index]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          );
        },
      ),
    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne, this.nameListAppend}) : super(key: key);
  final addOne;
  final nameListAppend;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Contact'),
      content: TextField(
        // onChanged: (text){print(text);},
        controller: inputData,
        decoration: InputDecoration(hintText: '이름'),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('cancel')),
        TextButton(onPressed: (){
          addOne();
          nameListAppend(inputData.text);
          Navigator.of(context).pop();
        }, child: Text('ok')),
      ],
    );
  }
}
