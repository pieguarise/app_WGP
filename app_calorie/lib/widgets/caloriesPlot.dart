import 'package:app_calorie/database/entities/entities.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomPlot extends StatelessWidget {
  const CustomPlot({
    Key? key,
    required this.listOfTrainings,
  }) : super(key: key);
  final List<Trainings> listOfTrainings;

@override
  Widget build(BuildContext context) {
   return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.7,
          child: Padding(
            padding: const EdgeInsets.only(right: 40, left:10, bottom: 10, top: 10 ),
            child: LineChart(
              mainData(listOfTrainings),
            ),
          ),
        ),
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.orange,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 500:
        text = '500';
        break;
      case 1000:
        text = '1000';
        break;
      case 1500:
        text = '1500';
        break;
      case 2000:
        text = '2000';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.right);
  }

  LineChartData mainData(List<Trainings> lista) {
    return LineChartData(
           
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: const Text(
            "Calories",
             style: 
             TextStyle(
              color: Colors.orange,
              fontSize: 15,
              fontWeight: FontWeight.bold
              ),),
          axisNameSize: 15,
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 35,
          ),
        ),
      ),
      
      minX: 0.9,
      maxX: 5,
      minY: -1,
      maxY: 2001,

      gridData: FlGridData(
        show:true,
        horizontalInterval: 250,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.orange.shade100,
            strokeWidth: 2
          );
        },
        drawVerticalLine: false
      ),

      borderData: FlBorderData(show: false ),

      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.amber.shade50,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              return LineTooltipItem(
                'Calories: ${listOfTrainings[5-flSpot.x.toInt()].calories} \n',
                const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.left,
                children: [
                  TextSpan(
                    text: 'Technique: ${listOfTrainings[5-flSpot.x.toInt()].technique} \n',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600
                      ),
                  ),
                  TextSpan(
                    text: 'Date: ${DateFormat('dd-MM-yyyy').format(listOfTrainings[5-flSpot.x.toInt()].date)} \n',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  TextSpan(
                    text: 'Time: ${DateFormat.jm().format(listOfTrainings[5-flSpot.x.toInt()].date)}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              );
            }).toList();
          },
        )
      ),
      
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, listOfTrainings[4].calories.toDouble()),
            FlSpot(2, listOfTrainings[3].calories.toDouble()),
            FlSpot(3, listOfTrainings[2].calories.toDouble()),
            FlSpot(4, listOfTrainings[1].calories.toDouble()),
            FlSpot(5, listOfTrainings[0].calories.toDouble()),
            ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.orange.shade700]),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
            colors: [Colors.orange.shade300.withOpacity(0.3), Colors.orange.shade800.withOpacity(0.3)]),

          ),

          barWidth: 10,
          dotData: FlDotData(
            show: true
          ),

        ),
      ],
    );
  }
}