import 'package:flutter/material.dart';
import 'style.dart' as style;

void main() {
  runApp(
    MaterialApp(
      theme: style.theme,
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined)),
        ],
      ),
      body: [Home(), Text('shop')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), label: 'home',
            // activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), label: 'shop',
            // activeIcon: Icon(Icons.shopping_bag)
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 3, itemBuilder: (context, index) {
      return Column(
        children: [
          Container(
            width: 500,
            height: 500,
            color: Colors.blueAccent,
          ),
          Container(
            // constraints: BoxConstraints(maxWidth: 600, maxHeight: 600),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('좋아요'),
                Text('글쓴이'),
                Text('글 내용'),
              ],
            ),
          )
        ],
      );
    });
  }
}
