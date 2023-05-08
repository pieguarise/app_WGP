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
          Text(
              "Congratulations! Your last session was the best among your last five.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF424242),
                  fontSize: 20,
                  fontStyle: FontStyle.italic)),
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
            "Reminder: When your most recent training session is the best among your last 5, we will DOUBLE the calories consumed in that session",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF424242),
                fontSize: 18,
                fontStyle: FontStyle.italic))
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Trainings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.italic
            ),
          ),
          Text('Calories consumption',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
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
          const SizedBox(height: 20),
          const Text(
            'Donations',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.italic
            ),
          ),
          Text('Current progress',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Column(children: [
            SizedBox(height: 5), 
          Consumer<TotalCal>(
            builder: (context, totalCalories, child) {
            return ProgressBar();})]),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(height: 10),
              Text(
                  "You can go to Achievements to donate. When you fill the bar we will make a donation and you'll get a coupon!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 18,
                      fontStyle: FontStyle.italic))
            ],
          ),
        ],
      ),
    );
  }
}
