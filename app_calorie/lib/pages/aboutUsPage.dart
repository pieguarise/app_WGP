import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);

  static const AboutUspageName = 'About Us';

  @override
  Widget build(BuildContext context) {
    print('${AboutUsPage.AboutUspageName} built');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade300,
        title: Text(AboutUsPage.AboutUspageName),
      ),
      body: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            gradient: LinearGradient(colors: [
          Colors.orange.shade100,
          const Color.fromARGB(255, 255, 255, 255)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          width: 400,
          height:
              420, //This helps the text widget know what the maximum width is again! You may also opt to use an Expanded widget instead of a Container widget, if you want to use all remaining space.
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Column(children: [
              SizedBox(height: 8),
              Text(
                'WGP',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'We are an application developer company that cooperates with well-known brands, organizations and cooperations with the purpose of giving the users innovative tools to be exploited in their daily life, pursuing at the same time charitable and humanitarian ends.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Train(ed) to Donate',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Text(
                'This is the perfect tool for you if you’re interested in tracking your daily performance in term of calories consumption. You will be able to have an immediate visualization of your last performances and enhancements. Moreover, based on your results, you’ll have the opportunity to get discounts from your favorites brands helping at the same time the World Food Programme in its fight against hunger.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 5),
              Text(
                'In Collaboration With',
                style: TextStyle(
                    fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/wfp.png')),
                SizedBox(width: 50),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/nike.png'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/bottecchia.png')),
                SizedBox(width: 50),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/lowa.png'),
                ),
              ],
            )
            ]),
            
          ),
        ),
    );
  } //build
} //AboutUsPage