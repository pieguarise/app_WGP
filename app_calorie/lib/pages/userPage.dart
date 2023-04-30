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

  @override
  Widget build(BuildContext context) {
    //print('${UserPage.UserpageName} built');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            width: 500,
            height: 230,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                colors: [
                  Colors.orange.shade200,
                  Color.fromARGB(255, 255, 255, 255)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Text(
                '$name',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 70,
                child: Image.asset('assets/batman.webp',),
              ),
            ])),
        Container(
          width: 350,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(children: [
              TextFormField(
                  decoration: InputDecoration(
                icon: Icon(MdiIcons.cake,color: Colors.orange,),
                hintText: 'Age',
              )),
              TextFormField(
                  decoration: InputDecoration(
                icon: Icon(MdiIcons.weightKilogram,color: Colors.orange,),
                hintText: 'Weigth',
              )),
            ])),
        SizedBox(
          height: 40,
        ),
        const Text(
          'Last donation',
          style: TextStyle(
              color: Colors.orange,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline),
          textScaleFactor: 1,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'On: ${DateUtils.dateOnly(date)}',
          textScaleFactor: 1.5,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Amount: $amount \$',
          textScaleFactor: 1.5,
        ),
        const SizedBox(
          height: 50,
        ),
        Card(
          elevation: 5,
          child: Container(
            width: 300,
            height: 100,
            color: Colors.orange.shade200,
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'Total donation:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('$amount \$',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
    ;
  }
} //Page


