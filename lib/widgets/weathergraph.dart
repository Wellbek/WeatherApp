import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeatherGraph extends StatefulWidget {
  @override
  State<WeatherGraph> createState() => _WeatherGraphState();
}

class _WeatherGraphState extends State<WeatherGraph> {
  LineTouchData get myLineTouchData => LineTouchData(
    handleBuiltInTouches: false,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.white,
    ),
  );

  FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false, reservedSize: 32),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles,
    ),
  );

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
      shadows: [
        Shadow(
              blurRadius:10.0,  // shadow blur
              color: Color.fromARGB(60, 0, 0, 0), // shadow color
              offset: Offset(2.0,2.0), // how much shadow will be shown
        ),
      ],
    );
    Widget text;

    if (value.toInt() % 2 == 0){
      text = Text("${(value.toInt() % 24).toString()}:00", style: style);
    } else { 
      text = const Text('');
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get leftTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: leftTitleWidgets,
  );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
      shadows: [
        Shadow(
              blurRadius:10.0,  // shadow blur
              color: Color.fromARGB(60, 0, 0, 0), // shadow color
              offset: Offset(2.0,2.0), // how much shadow will be shown
        ),
      ],
    );
    Widget text;
    
    if (value.toInt() % 10 == 0){
      text = Text("${value.toInt().toString()}°", style: style);
    } else { 
      text = const Text('');
    }

    return text;
  }
  
  LineChartBarData get myLineChartBarData => LineChartBarData(
    spots: [
      const FlSpot(0, 8),
      const FlSpot(1, 8),
      const FlSpot(2, 7),
      const FlSpot(3, 7),
      const FlSpot(4, 6),
      const FlSpot(5, 6),
      const FlSpot(6, 6),
      const FlSpot(7, 6),
      const FlSpot(8, 7),
      const FlSpot(9, 9),
      const FlSpot(10, 9),
      const FlSpot(11, 10),
      const FlSpot(12, 11),
      const FlSpot(13, 12),
      const FlSpot(14, 13),
      const FlSpot(15, 13),
      const FlSpot(16, 13),
      const FlSpot(17, 13),
      const FlSpot(18, 12),
      const FlSpot(19, 12),
      const FlSpot(20, 11),
      const FlSpot(21, 10),
      const FlSpot(22, 8),
      const FlSpot(23, 7),
      const FlSpot(24, 6) ,
    ],
    isCurved: true,
    color: const Color.fromARGB(255, 47, 196, 52),
    barWidth: 4,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: true,
      color: const Color.fromARGB(29, 73, 255, 109),
    )
  );
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 16, 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(36, 61, 61, 61),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          width: 800,
          height: 500,
          child: LineChart(
            chartData,
          ),
        ),
      )
    );
  }

  LineChartData get chartData => LineChartData(
    lineTouchData: myLineTouchData,
    gridData: FlGridData(show: false),
    titlesData: titlesData,
    borderData: FlBorderData(show: false),
    lineBarsData: [myLineChartBarData], 
    minX: -1, 
    maxX: 25,
    minY: -10,
    maxY: 45, 
  );
}