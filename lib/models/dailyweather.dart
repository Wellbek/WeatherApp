import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  double? tempMax;
  double? tempMin;
  String? day;
  String? currently;

  DailyWeather({
    this.tempMax,
    this.tempMin,
    this.day,
    this.currently
  });
}