import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:app_calorie/models/training.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: 225.0,
      lineHeight: 22.0,
      percent: sumCalLast5trainings(sessions: sessions2)/900,
      progressColor: Colors.orange,
      barRadius: const Radius.circular(10),
      trailing: Text(
        "${sumCalLast5trainings(sessions: sessions2).toInt()}/900 Calories",
        style: TextStyle(color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold)),
      center: Text(
        "${(sumCalLast5trainings(sessions: sessions2)/900*100).toInt()}%",
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold) 
        ),
      
    );
  }
}  