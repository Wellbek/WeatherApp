import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider/weatherdata.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      child: TextField(
        style: const TextStyle(color: Colors.black),
        maxLines: 1,
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
        onSubmitted: (value) {
          setState(() {
            _textController.text.isEmpty
                ? _validate = true
                : Provider.of<WeatherData>(context, listen: false)
                    .searchWeather(location: value);
          });
        },
      ),
    );
  }
}