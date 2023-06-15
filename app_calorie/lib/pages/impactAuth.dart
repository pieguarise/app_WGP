import 'dart:convert';
import 'package:app_calorie/pages/home.dart';
import 'package:app_calorie/pages/userPage.dart';
import 'package:app_calorie/utils/impact.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ImpactAuth extends StatelessWidget {
  ImpactAuth({Key? key}) : super(key: key);

  static const routename = 'ImpactAuth';

  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();

  void checkAuth(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    String _id = _textController1.text;
    String _psw = _textController2.text;
    if (_id == Impact.username && _psw == Impact.password) {
      final result = await _getAndStoreTokens();
      if (result == 200) {
        if (sp.getBool('firstTime') == null) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => UserPage())));
          });
        } else {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        }
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('Request failed')));
      }
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                child: Text(
                  'AUTHENTICATE',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  checkAuth(context);
                }),
          ],
        )),
      ),
    );
  }

// changeAuth
} //ImpactAuth

Future<int> _getAndStoreTokens() async {
  //Create the request
  final url = Impact.baseUrl + Impact.tokenEndpoint;
  final body = {'username': Impact.username, 'password': Impact.password};

  //Get the response
  print('Calling: $url');
  final response = await http.post(Uri.parse(url), body: body);

  //If response is OK, decode it and store the tokens. Otherwise do nothing.
  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    final sp = await SharedPreferences.getInstance();
    await sp.setString('access', decodedResponse['access']);
    await sp.setString('refresh', decodedResponse['refresh']);
  } //if

  //Just return the status code
  return response.statusCode;
} //_getAndStoreTokens
  