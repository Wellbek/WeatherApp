import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/weathergraph.dart';
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
            Container(
              margin: const EdgeInsets.symmetric( vertical: 130,),
              child: Column(     
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on_outlined, color: Colors.white,),
                      Text('Aachen', 
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Text('Germany', 
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric( vertical: 200,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('22°C', 
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 128,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.fromLTRB(20, 450, 20, 0),
              height: 200,
              child: 
                WeatherGraph()
            ),
          ],
        )
      )
    );
  }
}
