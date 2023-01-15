import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('성수동'),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            IconButton(onPressed: () {}, icon: Icon(Icons.add_alert)),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          height: 150,
          child: Row(
            children: [
              Image(image: AssetImage('assets/1700527_1.jpg'), width: 150, height: 150,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                    child: Text('캐논 카메라 팝니다.', style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                    child: Text('성수동 끌올 10분 전', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.grey),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                    child: Text('300,000원', style: TextStyle(fontSize: 17),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.favorite),
                      Text('4'),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
