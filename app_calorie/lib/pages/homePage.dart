import 'package:app_calorie/database/entities/entities.dart';
import 'package:app_calorie/repository/databaseRepository.dart';
import 'package:app_calorie/utils/trainingsFunctions.dart';
import 'package:flutter/material.dart';
import 'package:app_calorie/widgets/caloriesPlot.dart';
import 'package:app_calorie/widgets/progressBar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const route = '/HomePage/';
  static const routeDisplayName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Trainings> sessionsToPlot = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.orange.shade100,
          const Color.fromARGB(255, 255, 255, 255)
        ], begin: Alignment.topCenter, end: Alignment.center)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Trainings',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Calories consumption',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Consumer<DatabaseRepository>(
                            builder: (context, dbr, child) {
                          return FutureBuilder(
                              initialData: null,
                              future: dbr.findAllTrainings(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final allTrainings =
                                      snapshot.data as List<Trainings>;
                                  int n = allTrainings.length;
                                  if (n > 5) {
                                    sessionsToPlot =
                                        last5trainings(allTrainings, n);
                                    return Column(
                                      children: [
                                        const Text(
                                          "Your last 5 training sessions:",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        CustomPlot(
                                            listOfTrainings: sessionsToPlot),
                                        _toDisplayText(sessionsToPlot)
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
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text('Current progress',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Column(children: [
                    const SizedBox(height: 5),
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
                                    ProgressBar(consumedCal: CalAmountNow),
                                    const SizedBox(height: 10),
                                    const Text("Fill the bar and get a coupon!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 17,
                                        )),
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
                              return const SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircularProgressIndicator());
                            }
                          });
                    }),
                  ]),
                ])));
  }
}

Widget _toDisplayText(List<Trainings> recentTrainings) {
  if (compareTrainings(recentTrainings)) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 7,
          ),
          Text(
            "Good job!",
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          SizedBox(height: 5),
          Text(
            "Last session was the best among your last 5",
            style: TextStyle(
              color: Color(0xFF424242),
              fontSize: 18,
            ),
          ),
          Text(" WE WILL DOUBLE YOUR LAST SESSION'S CALORIES!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  } else {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 7,
        ),
        Text(
            "Reminder: If the most recent training session is the best among your last 5, we will DOUBLE the calories consumed in that session",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF424242), fontSize: 17))
      ],
    );
  }
}
