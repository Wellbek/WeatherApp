import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:weatherapp/models/hourlyweather.dart';
import 'package:weatherapp/models/dailyweather.dart';


import '../models/hourlyweather.dart';
import '../models/weather.dart';

class WeatherData with ChangeNotifier {
  String apiKey = 'cd8b7b4eb73babc6e5489995ae79bebd';
  LatLng? currentLocation;
  late Weather weather;
  HourlyWeather currentWeather = HourlyWeather();
  List<HourlyWeather> hourlyWeather = [];
  List<DailyWeather> dailyWeather = [DailyWeather(), DailyWeather(), DailyWeather()]; // next 3 days weather forecast
  bool isLoading = false;
  bool isRequestError = false;
  bool isLocationError = false;

  Future<void> getWeatherData({bool isRefresh = false}) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    if (isRefresh) notifyListeners();
    await Location().requestService().then(
      (value) async {
        if (value) {
          final locData = await Location().getLocation();
          currentLocation = LatLng(locData.latitude!, locData.longitude!);
          await getCurrentWeather(currentLocation!);
          await getHourlyWeather(currentLocation!);
        } else {
          isLoading = false;
          isLocationError = true;
          notifyListeners();
        }
      },
    );
  }

  Future<void> getCurrentWeather(LatLng location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      print(error.toString());
      isRequestError = true;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<void> getHourlyWeather(LatLng location) async {
    isLoading = true;
    notifyListeners();

    Uri hourlyUrl = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&units=metric&exclude=minutely,current&appid=$apiKey',
    );
    try {
      final response = await http.get(hourlyUrl);
      inspect(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      currentWeather = HourlyWeather.fromJson(extractedData['list'][0]);
      List<HourlyWeather> tempHourly = [];
      List itemsHourly = extractedData['list'];
      tempHourly = itemsHourly
          .map((item) => HourlyWeather.fromJson(item))
          .toList()
          .skip(1)
          .toList();
      hourlyWeather = tempHourly;

      var index = 0;

      for (var item in hourlyWeather){
        DateTime itemTime = item.date ?? DateTime.now();
        var tempIndex = daysBetween(DateTime.now(), itemTime);

        if (tempIndex == 0 || tempIndex > dailyWeather.length) continue;

        if (index != tempIndex){ // first entry of day so set its values as default for the day
          dailyWeather[tempIndex-1].tempMax = item.tempMax;
          dailyWeather[tempIndex-1].tempMin = item.tempMin;
          dailyWeather[tempIndex-1].day = DateFormat('EEEE').format(itemTime);
          dailyWeather[tempIndex-1].currently = item.currently;
          index = tempIndex;
        } else { // update maximum and minimum temperature of some day
          dailyWeather[tempIndex-1].tempMax = max(item.tempMax ?? 0, dailyWeather[tempIndex-1].tempMax ?? 0).ceilToDouble();
          dailyWeather[tempIndex-1].tempMin = min(item.tempMin ?? 0, dailyWeather[tempIndex-1].tempMin ?? 0).floorToDouble();
        }
      }
    } catch (error) {
      print(error.toString());
      isRequestError = true;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchWeatherWithLocation(String location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      isRequestError = true;
      rethrow;
    }
  }

  Future<void> searchWeather({required String location}) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    double latitude = weather.lat;
    double longitude = weather.long;
    await searchWeatherWithLocation(location);
    await getHourlyWeather(LatLng(latitude, longitude));
  }
}