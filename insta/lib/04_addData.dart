import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';


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
  var data = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
  }

  addData(a) {
    setState(() {
      data.add(a);
    });
  }

  
  // GET -> MyAppState load
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined)),
        ],
      ),
      body: [Home(data: data, addData: addData,), Text('shop')][tab],
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

class Home extends StatefulWidget {
  const Home({Key? key, this.data, this.addData}) : super(key: key);
  final data;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // scroll info
  var scroll = ScrollController();
  var flag = 1;

  getDataMore() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addData(result2);
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent && flag == 1){
        getDataMore();
        flag = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty){
      var dataLength = widget.data.length;
      return ListView.builder(itemCount: dataLength, controller: scroll, itemBuilder: (c, i) {
        return Column(
          children: [
            // Image.network(),
            Container(
              constraints: BoxConstraints(maxWidth: 600,),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.data[i]['image']),
                  Text('좋아요 ${widget.data[i]['likes'].toString()}'),
                  Text('글쓴이 ${widget.data[i]['user']}'),
                  Text('내용 ${widget.data[i]['content']}'),
                ],
              ),
            )
          ],
        );
      });
    } else {
      return CircularProgressIndicator();
    }
  }
}
