import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weatherapp/utils.dart';
import 'package:weatherapp/widgets/blinkingwidget.dart';
import 'package:weatherapp/widgets/weathergraph.dart';
import 'package:weatherapp/widgets/threedayforecast.dart';
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
  List<Widget> drawerElements = [];

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
    Utils.initCitylist();
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherData>(context, listen: false)
        .getWeatherData(isRefresh: true);
  }

  void addDrawerElement(String location){
    drawerElements.add(
      ListTile(
        title: Text(
          location, 
          style: const TextStyle(
            color: Color(0xff587ad8),
          )
        ),
        onTap: () {
          Provider.of<WeatherData>(context, listen: false).searchWeather(location: location);
        },
      )
    );
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
            return (_isLoading || weatherProv.isLoading)
            ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xff587ad8),
                  color: Colors.white,
                ),
              ),
            ) :
            Scaffold(   
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: true,
                title: Column(
                  children: [
                    Text( 
                      weatherProv.weather.cityName, 
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
                    Text(
                      weatherProv.weather.country,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
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
                actions: [
                  IconButton(
                    onPressed: () {setState(() {addDrawerElement(weatherProv.weather.cityName); });}, 
                    icon: const Icon(Icons.add_location_alt_outlined, color: Colors.white),
                  )
                ],
                backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                elevation: 0,
              ),
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                      child: DrawerHeader(
                        child: SearchBar(), 
                      ),
                    )
                  ]
                  + [ListTile(
                      title: Row(
                        children: const [
                          Icon(Icons.share_location_outlined, color: Color.fromARGB(255, 216, 99, 88),),
                          SizedBox(width: 10,),
                          Text(
                            'LIVE LOCATION', 
                            style: TextStyle(
                              color: Color.fromARGB(255, 216, 99, 88),
                            )
                          ),
                        ],   
                      ),
                      onTap: () {
                        Provider.of<WeatherData>(context, listen: false).getWeatherData(isRefresh: true);
                      },
                    )
                  ]
                  + drawerElements,           
                ),
              ),
              body: Stack(
                children: <Widget> [
                  const GradientMaterial(),
                  Container(
                    margin: const EdgeInsets.symmetric( vertical: 55,),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Utils.getWeatherIcon(weatherProv.weather.currently),
                            color: Colors.white,
                            size: 150,
                            shadows: const [
                                Shadow(
                                  blurRadius:10.0,  // shadow blur
                                  color: Color.fromARGB(60, 0, 0, 0), // shadow color
                                  offset: Offset(2.0,2.0), // how much shadow will be shown
                                ),
                              ],
                          ),
                          Text(weatherProv.weather.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                  Shadow(
                                    blurRadius:10.0,  // shadow blur
                                    color: Color.fromARGB(60, 0, 0, 0), // shadow color
                                    offset: Offset(2.0,2.0), // how much shadow will be shown
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text('${weatherProv.weather.temp.toStringAsFixed(0)}°C', 
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 90,
                              color: Colors.white,
                              shadows: [
                                  Shadow(
                                    blurRadius:10.0,  // shadow blur
                                    color: Color.fromARGB(60, 0, 0, 0), // shadow color
                                    offset: Offset(2.0,2.0), // how much shadow will be shown
                                  ),
                              ],
                            ),
                          ),
                          Text('${weatherProv.weather.tempMax.toStringAsFixed(0)}° / ${weatherProv.weather.tempMin.toStringAsFixed(0)}°', 
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                  Shadow(
                                    blurRadius:10.0,  // shadow blur
                                    color: Color.fromARGB(60, 0, 0, 0), // shadow color
                                    offset: Offset(2.0,2.0), // how much shadow will be shown
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.water_drop_outlined, color: Colors.white,),
                              Text(' ${weatherProv.weather.humidity} %', 
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white,
                                  shadows: [
                                      Shadow(
                                        blurRadius:10.0,  // shadow blur
                                        color: Color.fromARGB(60, 0, 0, 0), // shadow color
                                        offset: Offset(2.0,2.0), // how much shadow will be shown
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Icon(Icons.air_outlined, color: Colors.white,),
                              Text(' ${weatherProv.weather.windSpeed} m/s', 
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white,
                                  shadows: [
                                      Shadow(
                                        blurRadius:10.0,  // shadow blur
                                        color: Color.fromARGB(60, 0, 0, 0), // shadow color
                                        offset: Offset(2.0,2.0), // how much shadow will be shown
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.fromLTRB(15, 450, 15, 0),
                    height: 225,
                    child: 
                      WeatherGraph()
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 110,
                    margin: const EdgeInsets.fromLTRB(7.5, 690, 7.5, 0),
                    child: ThreeDayForecast(),
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