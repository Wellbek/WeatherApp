import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../provider/weatherdata.dart';

class WeatherGraph extends StatelessWidget {
  LineTouchData get myLineTouchData => LineTouchData(
    handleBuiltInTouches: true,
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

  LineChartBarData getMyLineChartBarData(dynamic weather){
    return LineChartBarData(
      spots: [
        FlSpot(weather.currentWeather.date.hour.toDouble(), weather.currentWeather.temp.toDouble()),
        FlSpot(weather.hourlyWeather[0].date.hour.toDouble(), weather.hourlyWeather[0].temp.toDouble()),
        FlSpot(weather.hourlyWeather[1].date.hour.toDouble(), weather.hourlyWeather[1].temp.toDouble()),
        FlSpot(weather.hourlyWeather[2].date.hour.toDouble(), weather.hourlyWeather[2].temp.toDouble()),
        FlSpot(weather.hourlyWeather[3].date.hour.toDouble(), weather.hourlyWeather[3].temp.toDouble()),
        FlSpot(weather.hourlyWeather[4].date.hour.toDouble(), weather.hourlyWeather[3].temp.toDouble()),
        FlSpot(weather.hourlyWeather[5].date.hour.toDouble(), weather.hourlyWeather[3].temp.toDouble()),
        FlSpot(weather.hourlyWeather[6].date.hour.toDouble(), weather.hourlyWeather[3].temp.toDouble()), 
        //FlSpot(2, weather.hourlyWeather[2]),
        //FlSpot(3, weather.hourlyWeather[3]),
        //FlSpot(4, weather.hourlyWeather[4]),
        //FlSpot(5, weather.hourlyWeather[5]),
        //FlSpot(6, weather.hourlyWeather[6]),
        //FlSpot(7, weather.hourlyWeather[7]),
        //FlSpot(8, weather.hourlyWeather[8]),
        //FlSpot(9, weather.hourlyWeather[9]),
        //FlSpot(10, weather.hourlyWeather[10]),
        //FlSpot(11, weather.hourlyWeather[11]),
        //FlSpot(12, weather.hourlyWeather[12]),
        //FlSpot(13, weather.hourlyWeather[13]),
        //FlSpot(14, weather.hourlyWeather[14]),
        //FlSpot(15, weather.hourlyWeather[15]),
        //FlSpot(16, weather.hourlyWeather[16]),
        //FlSpot(17, weather.hourlyWeather[17]),
        //FlSpot(18, weather.hourlyWeather[18]),
        //FlSpot(19, weather.hourlyWeather[19]),
        //FlSpot(20, weather.hourlyWeather[20]),
        //FlSpot(21, weather.hourlyWeather[21]),
        //FlSpot(22, weather.hourlyWeather[22]),
        //FlSpot(23, weather.hourlyWeather[23]),
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
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherData>(context);
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
            getChartData(weatherData),
          ),
        ),
      )
    );
  }

  LineChartData getChartData(dynamic weather){
    return LineChartData(
      lineTouchData: myLineTouchData,
      gridData: FlGridData(show: false),
      titlesData: titlesData,
      borderData: FlBorderData(show: false),
      lineBarsData: [getMyLineChartBarData(weather)], 
      minX: -1, 
      maxX: 25,
      minY: -10,
      maxY: 45, 
    );
  }
}