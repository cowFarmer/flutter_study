// make custom widget
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
  var name_list = ['이기영', '이기철', '땡구'];
  var name_list_count = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text('Contact'),
              content: TextField(
                onChanged: (value){},
                controller: TextEditingController(),
                decoration: InputDecoration(hintText: '010-0000-0000'),
              ),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('cancel')),
                TextButton(onPressed: (){}, child: Text('ok')),
              ],
            );
          });
        },
      ),
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 3,
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
