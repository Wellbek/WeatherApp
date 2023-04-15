import 'package:flutter/material.dart';
import '../widgets/searchbar.dart';
import '../materials/gradientmaterial.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget> [
            const GradientMaterial(),
            SearchBar(),
          ],
        )
      )
    );
  }
}
