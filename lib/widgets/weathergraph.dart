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
            TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            children: [ ((){
              // show current weather if raining, thunderstorm, drizzling or snowing
              String curr = (lineBarSpot.spotIndex== 0) ? weatherData.currentWeather.currently : weatherData.hourlyWeather[lineBarSpot.spotIndex].currently;
              if (["Rain", "Thunderstorm", "Drizzle", "Snow"].contains(curr)){ 
                return TextSpan(
                  text: "\n$curr",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.blue[700],
                  )
                );
              } else return const TextSpan();
            }()),
            ]
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
      text = Text("${value.toStringAsFixed(0)}°", style: style);
    } else { 
      text = const Text('');
    }

    return text;
  }

  LineChartBarData get myLineChartBarData => LineChartBarData(
    spots: [
      FlSpot(0, weatherData.currentWeather.temp),
      FlSpot(3, weatherData.hourlyWeather[0].temp),
      FlSpot(6, weatherData.hourlyWeather[1].temp),
      FlSpot(9, weatherData.hourlyWeather[2].temp),
      FlSpot(12, weatherData.hourlyWeather[3].temp),
      FlSpot(15, weatherData.hourlyWeather[4].temp),
      FlSpot(18, weatherData.hourlyWeather[5].temp),
      FlSpot(21, weatherData.hourlyWeather[6].temp), 
      FlSpot(24, weatherData.hourlyWeather[7].temp), 
    ],
    isCurved: true,
    color: Colors.white,
    barWidth: 4,
    dotData: FlDotData( 
      getDotPainter: (spot, percent, barData, index) {
        if (spot == barData.mostTopSpot){ // mark highest temp
          return FlDotCirclePainter( 
            radius: 5,
            color: Colors.red[400],
            strokeWidth: 2,
            strokeColor: Colors.white
          );
        }
        else if (spot == barData.mostBottomSpot){ // mark lowest temp
          return FlDotCirclePainter( 
            radius: 5,
            color: Colors.green[400],
            strokeWidth: 2,
            strokeColor: Colors.white
          );
        }
        else if (["Rain", "Thunderstorm", "Drizzle", "Snow"].contains( (index == 0) ? weatherData.currentWeather.currently : weatherData.hourlyWeather[index].currently)){ // mark rain, thunder, drizzle and snow with blue circles
          return FlDotCirclePainter( 
            radius: 5,
            color: Colors.blue[400],
            strokeWidth: 2,
            strokeColor: Colors.white
          );
        } else{
          return FlDotCirclePainter(
            radius: 4,
            color: Colors.grey[400],
            strokeWidth: 0,
          );
        }
      },
    ),
    belowBarData: BarAreaData(
      show: true,
      color: Color.fromARGB(29, 255, 255, 255),
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