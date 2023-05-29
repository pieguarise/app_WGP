import 'package:app_calorie/models/totalCal.dart';
import 'package:flutter/material.dart';
import 'package:app_calorie/models/training.dart';
import 'package:app_calorie/widgets/caloriesPlot.dart';
import 'package:app_calorie/widgets/progressBar.dart';
import 'package:provider/provider.dart';

Widget _toDisplayText(List<Training> recentTrainings) {
  if (compareTrainings(recentTrainings)) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Good job!",
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
            "Reminder: If the most recent training session is the best among your last 5, we will DOUBLE the calories consumed in that session",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF424242),
                fontSize: 17))
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  static const route = '/HomePage/';
  static const routeDisplayName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[
            Colors.orange.shade100,
            const Color.fromARGB(255, 255, 255, 255)],
          begin: Alignment.topCenter,
          end: Alignment.center
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 5,),
            const Text(
              'Trainings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
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
                  const Text(
                    "Your last 5 training sessions:",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const LineChartSample(),
                  _toDisplayText(sessions2),
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
              Consumer<TotalCal>(
                builder: (context, totalCalories, child) {
                return const ProgressBar();
              })]),
              const SizedBox(height: 10),
              const Text(
              "You can go to ACHIEVEMENTS to donate. \nFill the bar to get a branded COUPON and the brand will DONATE food correspondent consumed calories",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF424242),
                fontSize: 17,
              )
            ),   
          ]
        )
      )
    );
  }
}
