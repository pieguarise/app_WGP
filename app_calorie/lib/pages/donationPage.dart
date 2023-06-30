import 'package:app_calorie/database/entities/entities.dart';
import 'package:app_calorie/repository/databaseRepository.dart';
import 'package:app_calorie/widgets/bottomNotFull.dart';
import 'package:flutter/material.dart';
import 'package:app_calorie/widgets/radialScoreBoard.dart';
import 'package:app_calorie/widgets/bottomBarFullSection.dart';
import 'package:provider/provider.dart';

class DonationPage extends StatelessWidget {
  DonationPage({Key? key}) : super(key: key);

  static const AchievementsPageName = 'DonationPage';

  bool _barFull = false;

  //List<int> _variables = [];
  final int _maxRange = 20000;

  // è impostato anche su radialScoreBoard quindi se messa una vriabile vanno cambiati entrambi
  Widget _selectBottomSection({
    required bool fullness,
  }) {
    switch (fullness) {
      case false:
        return bottomBarNotFullSection();
      case true:
        return bottomBarFullSection();
      default:
        return bottomBarNotFullSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Donation page built');
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.change_circle),
                          onPressed: () async {

                            List<Totalcal> lista = await Provider.of<DatabaseRepository>(context, listen: false).findAllTotalCal();
                            int CalAmountNow = lista.last.amount; // solo se database non vuoto
                            if (CalAmountNow<_maxRange){
                              Totalcal totalcal = Totalcal(null, 20000) ;
                              await Provider.of<DatabaseRepository>(context, listen: false).insertCal(totalcal);
                            } else {
                              await Provider.of<DatabaseRepository>(context, listen: false).deleteCal(lista.last);
                          }}),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<DatabaseRepository>(
                      builder: (context, dbr, child) {
                    return FutureBuilder(
                        initialData: null,
                        future: dbr.findAllTotalCal(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final allTotalcal =
                                snapshot.data as List<Totalcal>;
                            int n = allTotalcal.length;
                            if (n > 0) {
                              int CalAmountNow = allTotalcal.last.amount;
                              return Column(
                                children: [
                                  SizedBox( width: 280, height: 280,
                                    child: scoreBoard(context, total: CalAmountNow>=_maxRange
                                      ? 20000 : CalAmountNow),
                                  ),
                                  _selectBottomSection(fullness: CalAmountNow>=_maxRange)
                                ],
                              );
                            } else {
                              return Center(
                                child: Text("Download data",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade700)),
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        });
                  })
                ])),
        
        SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}
