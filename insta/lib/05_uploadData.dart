import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  var userImage;
  var userContent;

  addMyData(){
    var myData = {
      'id': data.length,
      'image': userImage,
      'likes': 0,
      'data': 'July 25',
      'content': userContent,
      'liked': false,
      'user': 'me'
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  setUserContent(a){
    setState(() {
      userContent = a;
    });
  }

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
          IconButton(icon: Icon(Icons.add_box_outlined),
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null){
                setState(() {
                  userImage = File(image.path);
                });
              }

              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => Upload(
                    userImage: userImage, setUserContent: setUserContent,
                    addMyData: addMyData,
                  ))
              );
            },
          ),
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
    print(widget.data.length);
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
                  widget.data[i]['image'].runtimeType == String
                      ? Image.network(widget.data[i]['image'])
                      : Image.file(widget.data[i]['image']),
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

class Upload extends StatefulWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData}) : super(key: key);
  final userImage;
  final setUserContent;
  final addMyData;

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final uploadContentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),),
          Text('이미지업로드화면'),
          Image.file(widget.userImage),
          TextField(
            decoration: InputDecoration(
              hintText: '내용 입력하셈',
            ),
            onChanged: (text){
              widget.setUserContent(text);
            },
          ),
          // 버튼 누르면 upload
          IconButton(onPressed: (){
            widget.addMyData();
            Navigator.pop(context);
          },
          icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
