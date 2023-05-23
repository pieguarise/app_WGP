import 'package:app_calorie/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';
  
  const Splash({Key? key}) : super(key: key);


  void _checkAuth(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    
    final access = sp.getString('access');
    final refresh = sp.getString('refresh');
    
    String? username = prefs.username;
    String? password = prefs.password;

    // no user logged in the app
    if (username == null || password == null) {
      Future.delayed(const Duration(seconds: 1), () => _toLoginPage(context));
    } else {
      ImpactService service =
          Provider.of<ImpactService>(context, listen: false);
      bool responseAccessToken = await service.checkSavedToken();
      bool refreshAccessToken = await service.checkSavedToken(refresh: true);

      // if we have a valid token for impact, proceed
      if (responseAccessToken || refreshAccessToken) {
        // check if we have saved an api key for purpleair
        if (prefs.purpleAirXApiKey != null) {
          Future.delayed(
              const Duration(seconds: 1), () => _toHomePage(context));
        } else {
          Future.delayed(const Duration(seconds: 1), () => _toPurpleAirPage(context));
        }
      } else {
        Future.delayed(
            const Duration(seconds: 1), () => _toImpactPage(context));
      }
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())));
    // Future.delayed(const Duration(seconds: 1), () => _checkAuth(context));
    return Material(
      child: Container(
        color: Colors.orange.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text(
              'Our App Name',
              style: TextStyle(
                  color: Color.fromRGBO(255, 115, 0, 1),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
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
    );
  }
}