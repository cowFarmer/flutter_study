import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락');
      var contacts = await ContactsService.getContacts();
      print(contacts[0]);

      setState(() {
        name = contacts;
      });

    } else if (status.isDenied) {
      print('거절');
      Permission.contacts.request();
    }
  }

  // init은 위젯 로드될 떄 처음 한 번 실행함
  @override
  void initState() {
    super.initState();
    getPermission();
  }

  var total = 3;
  var name = [];

  // 자식 class에서 수정할 수 있게 함수 추가하기
  addOne(){
    setState(() {
      total++;
    });
  }


// var newPerson = Contact();
// newPerson.givenName = '민수';
// newPerson.familyName = '김';

  newPerson(name){
    setState(() {
      name.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return DialogUI(addOne: addOne, newPerson: newPerson);
          });
        },
      ),
      appBar: AppBar(title: Text(total.toString()), actions: [
        IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts))
      ],),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.account_circle_rounded, size: 45,),
            title: Text(name[index].givenName),
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
  DialogUI({Key? key, this.addOne, this.newPerson}) : super(key: key);
  final addOne;
  final newPerson;
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
          var newContact = Contact();
          newContact.givenName = inputData.text;
          ContactsService.addContact(newContact);
          Navigator.of(context).pop();
        }, child: Text('ok')),
      ],
    );
  }
}
