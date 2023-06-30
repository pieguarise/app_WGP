import 'package:app_calorie/database/entities/entities.dart';
import 'package:app_calorie/pages/aboutUsPage.dart';
import 'package:app_calorie/pages/donationPage.dart';
import 'package:app_calorie/pages/achievementsPage.dart';
import 'package:app_calorie/pages/homePage.dart';
import 'package:app_calorie/pages/instructionsPage.dart';
import 'package:app_calorie/pages/loginPage.dart';
import 'package:app_calorie/pages/splash.dart';
import 'package:app_calorie/pages/userPage.dart';
import 'package:app_calorie/repository/databaseRepository.dart';
import 'package:app_calorie/utils/requestData.dart';
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
      icon: Icon(MdiIcons.currencyUsd),
      label: 'Donation',
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
        return DonationPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('${Home.routeDisplayName} built');
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
                  Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
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
              ListTile(
                leading: const Icon(
                  MdiIcons.bookOpenVariant,
                  color: Colors.orange,
                  size: 35,
                ),
                title: const Text(
                  'Instructions',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InstructionsPage(),
                  ))
                }),
              ListTile(
                leading: const Icon(
                  MdiIcons.deleteOutline,
                  color: Colors.orange,
                  size: 35,
                ),
                title: const Text(
                  'Delete me',
                  style: TextStyle(fontSize: 20),
                ),
                onTap:() {
                  showDialog(context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        title: const Text('Delete me'),
                        content: const Text('Do you really want to delete all your data?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              List<Trainings> trainings = await Provider.of<DatabaseRepository>(context, listen: false).findAllTrainings();
                              for (var i=0; i<trainings.length; i++){
                                await Provider.of<DatabaseRepository>(context, listen: false).deleteTraining(trainings[i]);
                              }
                              List<Coupons> coupons = await Provider.of<DatabaseRepository>(context, listen: false).findAllCoupons();
                              for (var i=0; i<coupons.length; i++){
                                await Provider.of<DatabaseRepository>(context, listen: false).deleteCoupons(coupons[i]);
                              }
                              List<Totalcal> totalcal = await Provider.of<DatabaseRepository>(context, listen: false).findAllTotalCal();
                              for (var i=0; i<totalcal.length; i++){
                                await Provider.of<DatabaseRepository>(context, listen: false).deleteCal(totalcal[i]);
                              }
                              
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Splash()));

                              SharedPreferences ps = await SharedPreferences.getInstance();
                              ps.remove('login');
                              ps.remove('access');
                              ps.remove('refresh');
                              ps.remove('firstTime');
                              ps.remove('name');
                              ps.remove('nickName');
                              ps.remove('age');
                              ps.remove('weigth');
                              ps.remove('heigth');
                              ps.remove('donation');
                            }
                            ,
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                        ],
                      );
                    });
                }
              
              )
              
            ],
            
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange.shade300,
          actions: [
            IconButton(
                onPressed: () async {
                  final result = await requestData(context);
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
                      MaterialPageRoute(builder: (context) => AchievementsPage()));
                },
                icon: Icon(MdiIcons.giftOutline)),
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
