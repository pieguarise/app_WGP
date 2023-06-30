import 'package:app_calorie/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionsPage extends StatelessWidget {
  InstructionsPage({Key? key}) : super(key: key);

  static const InstructionspageName = 'Instructions';

  @override
  Widget build(BuildContext context) {
    print('${InstructionsPage.InstructionspageName} built');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade300,
      ),
      body: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            gradient: LinearGradient(colors: [
              Colors.orange.shade100,
              const Color.fromARGB(255, 255, 255, 255)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const Text(
                  'Instructions',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Basics',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(
                    "Train and consume calories to fill the bar.\nWhen you get to 25K kCal you can choose\nwhich brand will make a donation equal \nto 25K kCal in meals via WFP.\nYou will get a coupon of the chosen brand.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.orange.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 30),
                Text('Buttons',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(MdiIcons.trayArrowDown,
                        color: Colors.orange, size: 30),
                    SizedBox(width: 25),
                    Text("Download new data",
                        style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.home_outlined, color: Colors.orange, size: 30),
                    SizedBox(width: 25),
                    Text("Go to Home page,\nwhere you can see your progress",
                        style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(MdiIcons.currencyUsd, color: Colors.orange, size: 30),
                    SizedBox(width: 25),
                    Text(
                        "Go to Donation page,\nwhere you can get a coupon or donate",
                        style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(MdiIcons.giftOutline, color: Colors.orange, size: 30),
                    SizedBox(width: 25),
                    Text(
                        "Go to Achievement page,\nwhere you can use your coupons",
                        style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.person_2_outlined,
                        color: Colors.orange, size: 30),
                    SizedBox(width: 25),
                    Text(
                        "Go to User page, where\nyou can update your information",
                        style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(MdiIcons.deleteOutline,
                        color: Colors.orange, size: 30),
                    SizedBox(width: 25),
                    Text("Delete all your data from the app",
                        style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))
                  ],
                )
              ],
            )),
      ),
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.check_outlined, color: Colors.white),
        style: ElevatedButton.styleFrom(shape: CircleBorder()),
        onPressed: () async {
          SharedPreferences ps = await SharedPreferences.getInstance();
          if (ps.getBool('firstTime') == null) {
            ps.setBool('firstTime', false);
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text(
                      "You are ready to use the app for the first time!")));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Home()));
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  } //build
} //InstructionsPage