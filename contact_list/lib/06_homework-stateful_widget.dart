// make custom widget
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(name_list_count[index].toString()),
              title: Text(name_list[index]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(

                    style: TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue,),
                    onPressed: (){
                      setState(() {
                        name_list_count[index]++;
                      });
                    },
                    child: Text('좋아요')
                  ),
                ],
              ),
            );
          },
        ),
      )
    );
  }
}