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
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Transform(
            transform: Matrix4.translationValues(-30, 0, 0),
            child: Row(    
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white,),
                Column(
                  children: const [
                    Text(' Aachen', 
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
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
                    Text('Germany', 
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
              ],
            ),
          ),
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 80,
                child: DrawerHeader(
                  child: SearchBar(), 
                ),
              ),
              ListTile(
                title: const Text(
                  'Laurensberg', 
                  style: TextStyle(
                    color: Color(0xff587ad8),
                  )
                ),
                onTap: () {}
              ),              
              ListTile(
                title: const Text(
                  'Ibbenbüren', 
                  style: TextStyle(
                    color: Color(0xff587ad8),
                  )
                ),
                onTap: () {}
              )
            ]
          ),
        ),
        body: Stack(
          children: <Widget> [
            const GradientMaterial(),
            Container(
              margin: const EdgeInsets.symmetric( vertical: 200,),
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
              margin: const EdgeInsets.fromLTRB(15, 470, 15, 0),
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
