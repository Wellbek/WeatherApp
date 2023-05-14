import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/city.dart';

class Utils {

  static List<City> citylist = [];

  static Future<void> initCitylist() async{
    final String response = await rootBundle.loadString('lib/assets/citylist.json');
    final extractedData = await json.decode(response) as Map<String, dynamic>;
    List items = extractedData['list'];
    citylist = items.map((item) => City.fromJson(item)).toList();
  }

  static IconData getWeatherIcon(String currently){
    IconData res = Icons.sunny; //set sunny as default

    switch (currently) {
      case "Thunderstorm":
        res = Icons.thunderstorm;
        break;
      case "Drizzle":
        res = Icons.cloudy_snowing;
        break;
      case "Rain":
        res = Icons.cloudy_snowing;
        break;
      case "Snow":
        res = Icons.cloudy_snowing;
        break;
      case "Mist":
        res = Icons.foggy;
        break;
      case "Smoke":
        res = Icons.foggy;
        break;
      case "Haze":
        res = Icons.foggy;
        break;
      case "Dust":
        res = Icons.foggy;
        break;
      case "Fog":
        res = Icons.foggy;
        break;
      case "Sand":
        res = Icons.foggy;
        break;
      case "Ash":
        res = Icons.foggy;
        break;
      case "Squall":
        res = Icons.air;
        break;
      case "Tornado":
        res = Icons.tornado;
        break;
      case "Clear":
        res = Icons.sunny;
        break;
      case "Clouds":
        res = Icons.cloud;
        break;
      default:
        res = Icons.sunny;
        break;
    }

    return res;
  }
}