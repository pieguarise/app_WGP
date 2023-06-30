import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';


class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.consumedCal,
  }) : super(key: key);
  final int consumedCal;


  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: 225.0,
      lineHeight: 22.0,
      percent: consumedCal<25000 ? consumedCal/25000 : 1,
      progressColor: Colors.orange,
      barRadius: const Radius.circular(10),
      trailing: Text(
        "${consumedCal.toInt()}/25K Cal",
        style: TextStyle(color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold)),
      center: Text(
        "${(consumedCal/25000*100).toInt()}%",
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold) 
        ),
      
    );
  }
}  