import 'package:flutter/material.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 70,
        horizontal: MediaQuery.of(context).size.width * .05,
      ),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: TextField(
          style: TextStyle(color: Colors.black),
          maxLines: 1,
          controller: _textController,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _validate ? null : null,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            icon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,
                color: Colors.blue,
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: 0,
              bottom: 11,
              top: 11,
              right: 15,
            ),
            hintText: "Search Location",
          ),
        ),
      ),
    );
  }
}