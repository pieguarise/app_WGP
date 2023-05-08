import 'package:app_calorie/pages/couponsPage.dart';
import 'package:app_calorie/widgets/bottomNotFull.dart';
import 'package:flutter/material.dart';
import 'package:app_calorie/widgets/radialScoreBoard.dart';
import 'package:app_calorie/widgets/bottomBarFullSection.dart';
import 'package:app_calorie/models/training.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  static const AchievementsPageName = 'AchievementsPage';

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  int _barFull = 0;

  final int _maxRange = 180 * 5;
  // è impostato anche su radialScoreBoard quindi se messa una vriabile vanno cambiati entrambi

  // qui ci va di sicuro un CONSUMER LA CUI CLASS PROVIDER è LA QUANTITà DI CALORIE CONSUMATE
  void _onfullBar() {
    if (sumCalLast5trainings(sessions: sessions2) == _maxRange) {
      setState(() {
        _barFull = 1;
      });
    }
  }

  Widget _selectBottomSection({
    required int fullness,
  }) {
    switch (fullness) {
      case 0:
        return bottomBarNotFullSection();
      case 1:
        return bottomBarFullSection();
      default:
        return bottomBarNotFullSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    //print('${AchievementsPage.AchievementsPageName} built');
    return SingleChildScrollView(
      child: Column(children: [
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
                  Row(
                    children: const [
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
                      child: scoreBoard(context, session: sessions2))
                ])),
        _selectBottomSection(fullness: _barFull),
        SizedBox(
          height: 5,
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CouponsPage())),
          child: Icon(Icons.done),
        )
      ]),
    );
  }
}
