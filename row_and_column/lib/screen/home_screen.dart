import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.red,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.orange,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.yellow,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.green,
                    height: 50,
                    width: 50,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.orange,
                    height: 50,
                    width: 50,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.red,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.orange,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.yellow,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    color: Colors.green,
                    height: 50,
                    width: 50,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.green,
                    height: 50,
                    width: 50,
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
