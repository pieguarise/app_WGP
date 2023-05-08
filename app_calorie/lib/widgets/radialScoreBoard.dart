import 'package:app_calorie/models/training.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget scoreBoard(BuildContext context, {required List session}) {
  const double maxRange = 180 * 5; //for graph visualization range

  return Center(
      child: SfRadialGauge(
    enableLoadingAnimation: true,
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: maxRange, // is the max calories per 5 days

        axisLineStyle: const AxisLineStyle(thickness: 20),
        showTicks: false,
        pointers: <GaugePointer>[
          MarkerPointer(
              value: sumCalLast5trainings(sessions: session),
              enableDragging: true,
              enableAnimation: true,
              markerWidth: 15,
              markerHeight: 15,
              markerOffset: -18,
              color: Color.fromARGB(255, 248, 99, 7)),
          /*
          NeedlePointer(
              value: _sumCalLast5trainings(sessions2),
              //kCal,
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
          */
          RangePointer(
              value: sumCalLast5trainings(sessions: session),
              //kCal,
              enableDragging: true,
              gradient: const SweepGradient(colors: <Color>[
                Color.fromARGB(255, 255, 179, 0),
                Color.fromARGB(255, 248, 99, 7)
              ], stops: <double>[
                0.25,
                0.75
              ]),
              width: 20,
              enableAnimation: true,
              color: Colors.orange)
        ],
      )
    ],
  ));
}
