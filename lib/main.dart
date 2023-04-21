import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/weatherdata.dart';
import 'homescreen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherData(),
      child: MaterialApp(
        home: HomeScreen()
      )
    );
  }
}
