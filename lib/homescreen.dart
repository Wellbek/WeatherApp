import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/weathergraph.dart';
import 'package:provider/provider.dart';
import '../widgets/searchbar.dart';
import '../materials/gradientmaterial.dart';
import '../provider/weatherdata.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherData>(context, listen: false);
    weatherData.getWeatherData();
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherData>(context, listen: false)
        .getWeatherData(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<WeatherData>(
          builder: (context, weatherProv, _) {
            if (weatherProv.isLocationError){
              log("Location Error");
            }
            if (weatherProv.isRequestError){
              log("Request Error");
            }
            return Scaffold(   
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
                        children: [
                          Text(weatherProv.weather.cityName, 
                            style: const TextStyle(
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
                      children: [
                        Text('${weatherProv.weather.temp.toString().split('.')[0]}°C', 
                          style: const TextStyle(
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
            );
          }
        ),
      ),
    );
  }
}