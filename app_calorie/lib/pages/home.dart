import 'dart:io';
import 'dart:convert';

import 'package:app_calorie/database/entities/entities.dart';
import 'package:app_calorie/models/totalCal.dart';
import 'package:app_calorie/models/training.dart';
import 'package:app_calorie/pages/aboutUsPage.dart';
import 'package:app_calorie/pages/achievementsPage.dart';
import 'package:app_calorie/pages/couponsPage.dart';
import 'package:app_calorie/pages/homePage.dart';
import 'package:app_calorie/pages/impactAuth.dart';
import 'package:app_calorie/pages/loginPage.dart';
import 'package:app_calorie/pages/splash.dart';
import 'package:app_calorie/pages/userPage.dart';
import 'package:app_calorie/repository/databaseRepository.dart';
import 'package:app_calorie/utils/impact.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const route = '/home/';
  static const routeDisplayName = 'Home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selIdx = 0;

  List<BottomNavigationBarItem> _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(MdiIcons.trophyOutline),
      label: 'Achievements',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return AchievementsPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              ListTile(
                  leading: const Icon(
                    MdiIcons.logout,
                    color: Colors.orange,
                    size: 35,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    SharedPreferences ps =
                        await SharedPreferences.getInstance();
                    ps.remove('login');
                    ps.remove('access');
                    ps.remove('refresh');
                  }),
              ListTile(
                  leading: const Icon(
                    MdiIcons.informationOutline,
                    color: Colors.orange,
                    size: 35,
                  ),
                  title: const Text(
                    'About Us',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutUsPage(),
                        ))
                      }),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange.shade300,
          actions: [
            IconButton(
                onPressed: () async {
                  final result = await _requestData(context);
                  print(result);
                  final message =
                      result == null ? 'Request failed' : 'Request successful';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                icon: Icon(MdiIcons.trayArrowDown)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CouponsPage()));
                },
                icon: Icon(MdiIcons.gift)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserPage()));
                },
                icon: Icon(Icons.person_2_outlined)),
          ],
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 230, 81, 0)),
        ),
        body: _selectPage(index: _selIdx),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange.shade300,
          selectedItemColor: Colors.orange.shade900,
          items: _navBarItems,
          currentIndex: _selIdx,
          onTap: _onItemTapped,
        ));
  }
}

//This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
Future<int?> _requestData(context) async {
  //Initialize the result
  int? result;

  //Get the stored access token (Note that this code does not work if the tokens are null)
  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');
  var refresh = sp.getString('refresh');

  //If access token is expired, refresh it
  if (JwtDecoder.isExpired(access!)) {
    await refreshTokens(refresh);
    access = sp.getString('access');
  } //if

  //Create the (representative) request
  final day = '2023-04-18';
  final url = Impact.baseUrl +
      Impact.exerciseEndpoint +
      Impact.patientUsername +
      '/day/$day/';
  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

  //Get the response
  print('Calling: $url per richiesta dati');
  final response = await http.get(Uri.parse(url), headers: headers);
  print('${response.body}');
  print('La risposta è: $response');
  //if OK parse the response, otherwise return null
  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    result = response.statusCode;
    for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
      Trainings training = _generateTraining(
          decodedResponse['data']['date'], decodedResponse['data']['data'][i]);
      print(training.date);
      await Provider.of<DatabaseRepository>(context, listen: false)
          .insertTraining(training);
      print('bau');
    } //for
    print('miao');
    List<Trainings> lista =
        await Provider.of<DatabaseRepository>(context, listen: false)
            .findAllTrainings();
    print(lista);
  } //if
  else {
    result = null;
  } //else

  //Return the result
  return result;
} //_requestData

Trainings _generateTraining(String day, Map<String, dynamic> json) {
  DateTime date =
      DateFormat('yyyy-MM-dd HH:mm:ss').parse('$day ${json["time"]}');
  int calories = json["calories"];
  String technique = json["activityName"];

  Trainings result = Trainings(null, date, calories, technique);
  return result;
}
