import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app_calorie/pages/homePage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AchievementsPage extends StatefulWidget {
  AchievementsPage({Key? key}) : super(key: key);

  static const AchievementsPageName = 'AchievementsPage';

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //print('${AchievementsPage.AchievementsPageName} built');
    return Scaffold(
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
                      width: 280,
                      height: 280,
                      child: _scoreBoard(context, kCal: 80),
                    )
                  ])),
          const _bottomAchievementsPage(),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.done),
          //Provider.of<Cart>(context, listen: false).clearCart(),
        ));
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
                needleColor: const Color(0xFFDADADA),
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

class _bottomAchievementsPage extends StatefulWidget {
  const _bottomAchievementsPage({super.key});

  @override
  State<_bottomAchievementsPage> createState() =>
      __bottomAchievementsPageState();
}

class __bottomAchievementsPageState extends State<_bottomAchievementsPage> {
  int? radioValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Congratulations!',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        const Text(
          'select the member to get the discount!',
          style: TextStyle(
              fontSize: 15, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(height: 250, child: _listViewMembers()),
        ),
      ],
    );
  }
}

class _listViewMembers extends StatefulWidget {
  const _listViewMembers({super.key});

  @override
  State<_listViewMembers> createState() => __listViewMembersState();
}

class __listViewMembersState extends State<_listViewMembers> {
  final List<String> members = ['Nike', 'Lowa', 'Bottecchia'];
  List<double> memb_num = [1, 2, 3];
  //final List<bool> members_bool = [false, false, false];
  List<String> pathsImages = [
    'assets/nike.png',
    'assets/lowa.png',
    'assets/bottecchia.png',
  ];

  num? radioValue;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          minVerticalPadding: 0.5,
          title: Text(members[index]),
          leading: Radio(
            fillColor: MaterialStateColor.resolveWith(
                (states) => const Color(0xFF89453C)),
            value: memb_num[index],
            groupValue: radioValue,
            onChanged: (val) {
              setState(() {
                radioValue = val;
              });
            },
          ),
          trailing: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.asset(
              pathsImages[index],
            ),
          ),
          visualDensity: VisualDensity(horizontal: 0),
        );
      },
    );
  }
}
/*
Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xFF89453C)),
                          value: 0,
                          groupValue: radioValue,
                          onChanged: (val) {
                            setState(() {
                              radioValue = val;
                            });
                          },
                        ),
                        */