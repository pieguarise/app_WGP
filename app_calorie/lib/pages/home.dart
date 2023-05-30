import 'package:app_calorie/models/couponsList.dart';
import 'package:app_calorie/models/totalCal.dart';
import 'package:app_calorie/pages/aboutUsPage.dart';
import 'package:app_calorie/pages/achievementsPage.dart';
import 'package:app_calorie/pages/couponsPage.dart';
import 'package:app_calorie/pages/homePage.dart';
import 'package:app_calorie/pages/impactAuth.dart';
import 'package:app_calorie/pages/loginPage.dart';
import 'package:app_calorie/pages/userPage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              onPressed: ()async{
                final result = await _getData();
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
  Future<List<Training>?> _getData() async {
    //Initialize the result
    List<Training>? result;

 //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final day = '2023-05-04';
    final url = Impact.baseUrl + Impact.stepsEndpoint + Impact.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        result.add(Steps.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data'][i]));
      }//for
    } //if
    else{
      result = null;
    }//else

    //Return the result
    return result;

  } //_requestData