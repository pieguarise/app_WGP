import 'package:app_calorie/pages/homePage.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  static const route = '/home/';
  static const routeDisplayName = 'Home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selIdx = 0;

  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      label: 'User',
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
        return const HomePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          /*
          child: ListView(
            children: [
              ListTile(
                  leading: const Icon(MdiIcons.logout),
                  title: const Text('Logout'),
                  // delete all data from the database
                  onTap: () => {}),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('About'),
              ),
              ListTile(
                  leading: const Icon(MdiIcons.imageFilterDrama),
                  title: const Text('Pollution Information'),
                  // delete all data from the database
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InfoPollutants(),
                        ))
                      }),
              ListTile(
                  leading: const Icon(MdiIcons.dotsHexagon),
                  title: const Text('Exposure Information'),
                  // delete all data from the database
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InfoExposure(),
                        ))
                      }),
            ],
          ),
          */
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange.shade300,
          /*
          iconTheme: const IconThemeData(color: Color(0xFF89453C)),
          elevation: 0,
          backgroundColor: const Color(0xFFE4DFD4),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => Profile()));
                  },
                  icon: const Icon(
                    MdiIcons.accountCircle,
                    size: 40,
                    color: Color(0xFF89453C),
                  )),
            )
          ],
          */
        ),
        body: _selectPage(index: _selIdx),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange.shade300,
          selectedItemColor: Colors.orange.shade900,
          items: navBarItems,
          currentIndex: _selIdx,
          onTap: _onItemTapped,
        ));
  }
}