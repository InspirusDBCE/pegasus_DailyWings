import 'package:flutter/material.dart';

// constant Decorated textfield for user input

const constant_textfield = InputDecoration(
  fillColor: Color(0xFF8998BF),
  filled: true,
  /* enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ), */
  enabledBorder: InputBorder.none,
  hintText: 'Enter Data',
  hintStyle: TextStyle(color: Colors.white), 
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
);
