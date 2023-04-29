import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/utils.dart';

import '../provider/weatherdata.dart';

class ThreeDayForecast extends StatelessWidget {
  dynamic weatherData;
  TextStyle style = const TextStyle(
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

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherData>(context);
    return Row(
      children: [
        weatherWidget(context, 0),
        weatherWidget(context, 1),
        weatherWidget(context, 2),
      ],
    );
  }

  Container weatherWidget(BuildContext context, int index){
    return Container(
      height: 110,
      width: (MediaQuery.of(context).size.width - 3*15 - 15) / 3, // width = (screenwidth - widget padding - outer container padding) / widget amount 
      margin: const EdgeInsets.fromLTRB(7.5, 0, 7.5,0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(36, 61, 61, 61),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "${weatherData.dailyWeather[index].day}",
            style: style,
          ),
          const SizedBox(height: 10),
          Icon(Utils.getWeatherIcon(weatherData.dailyWeather[index].currently), color: Colors.white,),
          const SizedBox(height: 10),
          Text(
            "${weatherData.dailyWeather[index].tempMax.toStringAsFixed(0)}° / ${weatherData.dailyWeather[index].tempMin.toStringAsFixed(0)}°",
            style: style,
          ),
        ]
      ),
    );
  }
}