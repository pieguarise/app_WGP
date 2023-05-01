import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app_calorie/models/training.dart';

class LineChartSample extends StatelessWidget {
  const LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.30,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: LineChart(
              mainData(),
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
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
        break;
      case 200:
        text = '200';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.right);
  }

  LineChartData mainData() {
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
            reservedSize: 30,
          ),
        ),
      ),
      
      minX: 0.9,
      maxX: 5,
      minY: -1,
      maxY: 201,

      gridData: FlGridData(
        show:true,
        horizontalInterval: 25,
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
          // getTooltipItems: 
         )
       ),

      // backgroundColor: Colors.amber[50],

      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, sessions2[4].calories.toDouble()),
            FlSpot(2, sessions2[3].calories.toDouble()),
            FlSpot(3, sessions2[2].calories.toDouble()),
            FlSpot(4, sessions2[1].calories.toDouble()),
            FlSpot(5, sessions2[0].calories.toDouble()),
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