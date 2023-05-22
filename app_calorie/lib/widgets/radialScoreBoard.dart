import 'package:app_calorie/models/training.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget scoreBoard(BuildContext context, {required double totale}) {
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
              value: totale,
              enableDragging: true,
              enableAnimation: true,
              markerWidth: 15,
              markerHeight: 15,
              markerOffset: -18,
              color: Color.fromARGB(255, 248, 99, 7)),

          RangePointer(
              value: totale,
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
