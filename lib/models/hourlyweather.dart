import 'package:flutter/cupertino.dart';

class HourlyWeather with ChangeNotifier {
  final double? temp;
  final double? tempMax;
  final double? tempMin;
  final double? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? windSpeed;
  final DateTime? date;
  final String? currently;

  HourlyWeather({
    this.temp,
    this.tempMax,
    this.tempMin,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.date,
    this.currently,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      temp: (json['main']['temp']).toDouble(),
      tempMax: (json['main']['temp_max']).toDouble(),
      tempMin: (json['main']['temp_min']).toDouble(),
      feelsLike: (json['main']['feels_like']).toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed']).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      currently: json['weather'][0]['main'],
    );
  }
}