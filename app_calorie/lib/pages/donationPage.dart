import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app_calorie/pages/homePage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DonationPage extends StatefulWidget {
  DonationPage({Key? key}) : super(key: key);

  static const DonationPageName = 'DonationPage';

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //print('${DonationPage.DonationPageName} built');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade300,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 230, 81, 0)),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              //Provider.of<Cart>(context, listen: false).clearCart(),
              icon: const Icon(Icons.done))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
            width: 700,
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'YOUR KCAL COUNTER',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: _scoreBoard(context, kCal: 80),
                  )

                  /*
              CircleAvatar(
                radius: 70,
                child: Image.asset(
                  'assets/batman.webp',
                ),
              ),
              */
                ])),
        _bottomDonationPage(),
      ]),
    );
  }
} //Page

Widget _scoreBoard(BuildContext context, {required double kCal}) {
  return Center(
      child: SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
          axisLineStyle: const AxisLineStyle(thickness: 30),
          showTicks: false,
          pointers: <GaugePointer>[
            NeedlePointer(
                value: kCal,
                enableAnimation: true,
                needleStartWidth: 0,
                needleEndWidth: 5,
                needleColor: Color(0xFFDADADA),
                knobStyle: const KnobStyle(
                    color: Colors.white,
                    borderColor: Color(0xFFDADADA),
                    knobRadius: 0.06,
                    borderWidth: 0.04),
                tailStyle: const TailStyle(
                    color: Color(0xFFDADADA), width: 5, length: 0.15)),
            RangePointer(
                value: kCal,
                width: 30,
                enableAnimation: true,
                color: Colors.orange)
          ])
    ],
  ));
}

class _bottomDonationPage extends StatefulWidget {
  const _bottomDonationPage({super.key});

  @override
  State<_bottomDonationPage> createState() => __bottomDonationPageState();
}

class __bottomDonationPageState extends State<_bottomDonationPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Congratulations!',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'select the member to get the discount!',
            style: TextStyle(
                fontSize: 15, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(width: 400, height: 250, child: _listViewMembers()),
        ],
      ),
    );
  }
}

Widget _listViewMembers() {
  final List<String> members = ['Nike', 'Lowa', 'Bottecchia'];
  return ListView.builder(
    itemCount: members.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        selected: true,
        selectedColor: Colors.red,
        leading: const Icon(Icons.list),
        title: Text(members[index]),
        trailing: Text('sconto'),
      );
    },
  );
}
