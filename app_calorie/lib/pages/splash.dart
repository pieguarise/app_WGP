import 'dart:convert';
import 'package:app_calorie/pages/home.dart';
import 'package:app_calorie/pages/impactAuth.dart';
import 'package:app_calorie/pages/loginPage.dart';
import 'package:app_calorie/utils/impact.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  void _checkImpact(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();

    final access = sp.getString('access');
    final refresh = sp.getString('refresh');
    bool? login = sp.getBool('login');

    // no user logged in the app
    if (login == null) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => LoginPage())));
      });
    } else {
      // if we don't have any token for impact --> ImpactAuth
      if (access == null || refresh == null) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => ImpactAuth())));
        });
      } else {
        // new tokens if refresh is expired
        if (JwtDecoder.isExpired(refresh)) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => ImpactAuth())));
          });
        } else {
          // refresh tokens if only access is expired
          if (JwtDecoder.isExpired(access)) {
            refreshTokens(refresh);
          }
          // if our access token isn't expired --> Home
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => Home())));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () => _checkImpact(context));
    return Material(
      child: Container(
        color: Colors.orange.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/wgp.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Train to Donate',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

Future<void> refreshTokens(refresh) async {
  final url = Impact.baseUrl + Impact.refreshEndpoint;
  final body = {'refresh': refresh};
  //print('Calling: $url');
  final response = await http.post(Uri.parse(url), body: body);
  // print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final decodeBody = jsonDecode(response.body);
    final access = decodeBody['access'];
    final refresh = decodeBody['refresh'];
    final sp = await SharedPreferences.getInstance();
    await sp.setString('access', access);
    await sp.setString('refresh', refresh);
  }
  return;
} //refreshTokens