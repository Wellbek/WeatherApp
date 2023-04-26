import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/hourlyweather.dart';

import '../provider/weatherdata.dart';

class WeatherGraph extends StatelessWidget {

  dynamic weatherData;

  LineTouchData get myLineTouchData => LineTouchData(
    touchSpotThreshold: 40,
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.white,
      getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
        return lineBarsSpot.map((lineBarSpot) {
          return LineTooltipItem(
            "${lineBarSpot.y.toInt()}°C",
            const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList();
      },
      tooltipMargin: 50,
      fitInsideHorizontally: true,
      fitInsideVertically: true,
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

    if (value.toInt() % 3 == 0){
      if (value~/3 == 0){
          text = Text("${(weatherData.currentWeather.date.hour % 24).toString()}:00", style: style);
      } else {
        text = Text("${(weatherData.hourlyWeather[(value~/3)-1].date.hour % 24).toString()}:00", style: style);
      }
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
      FlSpot(0, weatherData.currentWeather.temp.toDouble()),
      FlSpot(3, weatherData.hourlyWeather[0].temp.toDouble()),
      FlSpot(6, weatherData.hourlyWeather[1].temp.toDouble()),
      FlSpot(9, weatherData.hourlyWeather[2].temp.toDouble()),
      FlSpot(12, weatherData.hourlyWeather[3].temp.toDouble()),
      FlSpot(15, weatherData.hourlyWeather[4].temp.toDouble()),
      FlSpot(18, weatherData.hourlyWeather[5].temp.toDouble()),
      FlSpot(21, weatherData.hourlyWeather[6].temp.toDouble()), 
      FlSpot(24, weatherData.hourlyWeather[7].temp.toDouble()), 
    ],
    isCurved: true,
    color: const Color.fromARGB(255, 47, 196, 52),
    barWidth: 4,
    dotData: FlDotData(show: true,),
    belowBarData: BarAreaData(
      show: true,
      color: const Color.fromARGB(29, 73, 255, 109),
    )
  );

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherData>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 16, 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(36, 61, 61, 61),
      ),
      child: 
      Column(   
        children: [
          Row(    
            children: const [
              Icon(Icons.access_time, color: Colors.white,),
              Text(' temperature next 24 hours', 
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius:10.0,  // shadow blur
                      color: Color.fromARGB(60, 0, 0, 0), // shadow color
                      offset: Offset(2.0,2.0), // how much shadow will be shown
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            ]
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 800,
              height: 170,
              child: LineChart(
                chartData,
              ),
            ),
          ),
        ],
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