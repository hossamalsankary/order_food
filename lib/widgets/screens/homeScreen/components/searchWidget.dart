import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final Function() onpressIcon;
  final Function(String) onchange;
  SearchWidget(
      {required this.controller,
      required this.onSubmitted,
      required this.onchange,
      required this.onpressIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      onChanged: onchange,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            width: 0.8,
            color: Theme.of(context).accentColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            width: 0.8,
            color: Theme.of(context).accentColor,
          ),
        ),
        hintText: 'Search Food or Restaurants',
        suffixIcon: IconButton(
          onPressed: onpressIcon,
          icon: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
