import 'package:app_calorie/pages/home.dart';
import 'package:app_calorie/pages/homePage.dart';
import 'package:flutter/material.dart';

class ImpactAuth extends StatelessWidget {
  ImpactAuth({Key? key}) : super(key: key);

  static const routename = 'ImpactAuth';

  final _textController1 = TextEditingController();

  final _textController2 = TextEditingController();

  void checkUser(BuildContext context) {
    String _id = _textController1.text;
    String _psw = _textController2.text;
    if (_id == "name" && _psw == "password") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong credentials'),
          duration: const Duration(seconds: 2),
        ),
      );
    } // if
  }

  @override
  Widget build(BuildContext context) {
    print('$routename built');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade200,
              const Color.fromARGB(255, 255, 255, 255)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset('assets/impact_logo.png'),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    labelText: "Username",
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder()),
                controller: _textController1,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder()),
                controller: _textController2,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                child: Text('AUTHENTICATE',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  checkUser(context);
                }),
          ],
        )),
      ),
    );
  }

// checkUser
} //ImpactAuth