import 'package:app_calorie/pages/home.dart';
import 'package:app_calorie/pages/homePage.dart';
import 'package:app_calorie/pages/impactAuth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const routename = 'LoginPage';

  final _textController1 = TextEditingController();

  final _textController2 = TextEditingController();

  void checkUser(BuildContext context) async {
    String _id = _textController1.text;
    String _psw = _textController2.text;
    if (_id == "wgp" && _psw == "0000") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => ImpactAuth())));
      SharedPreferences ps = await SharedPreferences.getInstance();
      ps.setBool('login', true);
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
      body: toDisplayBody(context),
    );
  }

  Container toDisplayBody(BuildContext context){
    //SharedPreferences ps = SharedPreferences.getInstance();
    //if (ps.getBool('firstTime') == false) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade100,
            const Color.fromARGB(255, 255, 255, 255)
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset('assets/wgp.png'),
          ),
          SizedBox(height: 40,),
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
              child: Text('LOGIN',style: TextStyle(color: Colors.white),),
              onPressed: () {
                checkUser(context);
              }),
        ],
      )),
    );}
    /*else {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade100,
            const Color.fromARGB(255, 255, 255, 255)
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset('assets/wgp.png'),
          ),
          SizedBox(height: 40,),
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
              child: Text('LOGIN',style: TextStyle(color: Colors.white),),
              onPressed: () {
                checkUser(context);
              }),
        ],
      )),
    );}*/
  //}
  

// checkUser
} //LoginPage