import 'package:flutter/material.dart';
class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);

  static const AboutUspageName = 'About Us';

  @override
  Widget build(BuildContext context) {
    //print('${AboutUsPage.AboutUspageName} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(AboutUsPage.AboutUspageName),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: 400,
              height:
                  400, //This helps the text widget know what the maximum width is again! You may also opt to use an Expanded widget instead of a Container widget, if you want to use all remaining space.
              child: Column(children: [
                Text(
                  '\n\nQui\nraccontiamo\nchi\nsiamo\ne\ncosa\npropone\nla\nnostra\napp\n...',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            SizedBox(height: 30),
            Text(
              'In Collaboration With',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/bottecchia.png')),
                    
                    SizedBox(width: 100),

                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/nike.png'),
                    )
                  ],
                ),
                Center(child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/lowa.png'),
                    ),)
              ],
            )
          ],
        ),
      ),
    );
  } //build
} //AboutUsPage