import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider/darktheme.dart';
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
      child: ChangeNotifierProvider(
        create: (context) => DarkThemeProvider(),
        child: MaterialApp(
          home: HomeScreen()
        ),
      )
    );
  }
}
