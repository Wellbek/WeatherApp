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
              margin: const EdgeInsets.symmetric( vertical: 150,),
              child: Column(     
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on_outlined, color: Colors.white,),
                      Text('Aachen', 
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
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
                      ),
                    ],
                  ),
                  const Text('Germany', 
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
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
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric( vertical: 230,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('22°C', 
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 100,
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
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.fromLTRB(30, 470, 30, 0),
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
