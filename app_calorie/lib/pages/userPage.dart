import 'package:app_calorie/pages/couponsPage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  static const UserpageName = 'UserPage';

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final String name = 'Bruce Wayne (Batman)';

  final DateTime date = DateTime.now();

  final double amount = 100;

  final int age = 30;

  double weigth = 100;

  List<Widget> _listTiles = [];

  @override
  Widget build(BuildContext context) {
    //print('${UserPage.UserpageName} built');
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 500,
                  height: 230,
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
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '$name',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 70,
                      child: Image.asset(
                        'assets/batman.webp',
                      ),
                    ),
                  ])),
              Container(
                  width: 350,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(children: [
                    TextFormField(
                        decoration: const InputDecoration(
                      icon: Icon(
                        MdiIcons.cake,
                        color: Colors.orange,
                      ),
                      hintText: 'Age',
                    )),
                    TextFormField(
                        decoration: const InputDecoration(
                      icon: Icon(
                        MdiIcons.weightKilogram,
                        color: Colors.orange,
                      ),
                      hintText: 'Weigth',
                    )),
                    TextFormField(
                        decoration: const InputDecoration(
                      icon: Icon(
                        MdiIcons.tapeMeasure,
                        color: Colors.orange,
                      ),
                      hintText: 'Heigth',
                    )),
                  ])),
              const SizedBox(
                height: 40,
              ),
              
            ],
          ),
        ));
  }
}
