import 'package:app_calorie/models/totalCal.dart';
import 'package:app_calorie/pages/couponsPage.dart';
import 'package:app_calorie/widgets/bottomNotFull.dart';
import 'package:flutter/material.dart';
import 'package:app_calorie/widgets/radialScoreBoard.dart';
import 'package:app_calorie/widgets/bottomBarFullSection.dart';
import 'package:app_calorie/models/training.dart';
import 'package:provider/provider.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  static const AchievementsPageName = 'AchievementsPage';

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  int _barFull = 0;
  List<int> _variables = [];

  final int _maxRange = 180 * 5;
  // è impostato anche su radialScoreBoard quindi se messa una vriabile vanno cambiati entrambi

  // qui ci va di sicuro un CONSUMER LA CUI CLASS PROVIDER è LA QUANTITà DI CALORIE CONSUMATE
  void _onfullBar() {
    if (sumCalLast5trainings(sessions: sessions2) == _maxRange) {
      setState(() {
        _barFull = 0;
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
    return Consumer<TotalCal>(builder: (context, TotalCalories, child) {
      return SingleChildScrollView(
        child: Column(children: [
          Container(
              width: 700,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade100,
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
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Your Kcal counter',
                          style: TextStyle(
                            color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,),
                        ),
                        IconButton(
                            icon: Icon(Icons.change_circle),
                            onPressed: () {
                              setState(() {
                                _barFull == 0 ? _barFull = 1 : _barFull = 0;
                              });
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 280,
                        height: 280,
                        // se non piena, calcola il valore dalla lista degli allenamenti, altrimenti riempie la barra secondo il massimo definito in scoreBoard
                        child: scoreBoard(context, totale: _barFull == 0 ? sumCalLast5trainings(sessions: sessions2) : 180*5)),
                  ])),
          _selectBottomSection(fullness: _barFull),
          SizedBox(
            height: 5,
          ),
        ]),
      );
    });
  }
}
