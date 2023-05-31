import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider/weatherdata.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:weatherapp/provider/darktheme.dart';

import '../models/city.dart';
import '../utils.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;

  GlobalKey<AutoCompleteTextFieldState<City>> key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, themeProv, _){
        return Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          color: themeProv.darkTheme ? Colors.grey[900] : Colors.white,
          child: AutoCompleteTextField<City>(
            cursorColor: themeProv.darkTheme ? const Color(0xff587ad8) : Colors.black,
            style: TextStyle(color: themeProv.darkTheme ? Colors.white : Colors.black),
            controller: _textController,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.grey),
              errorText: _validate ? null : null,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              icon: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  color: Color(0xff587ad8),
                ),
              ),
              contentPadding: const EdgeInsets.only(
                left: 0,
                bottom: 11,
                top: 11,
                right: 15,
              ),
              hintText: "Search Location",
            ),
            itemFilter: (item, query) {
              return item.name.toLowerCase().startsWith(query.toLowerCase());
            },
            suggestions: Utils.citylist,
            key: key,
            itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion.name),
                  trailing: Text(suggestion.country)),
            itemSorter: (a, b) => a.name == b.name //sort alphabetically
              ? 0
              : a.name.compareTo(b.name) < 0
                ? -1
                : 1,
            itemSubmitted: (city) {
              setState(() {
                _textController.text.isEmpty
                    ? _validate = true
                    : Provider.of<WeatherData>(context, listen: false)
                        .searchWeather(location: city.name, lat: city.lat, lon: city.long);
              });
            },
            textSubmitted: (input) { 
              setState(() {
                _textController.text.isEmpty
                    ? _validate = true
                    : Provider.of<WeatherData>(context, listen: false)
                        .searchWeather(location: input);
              });
            },
          ),
        );
      }
    );
  }
}