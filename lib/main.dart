import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/screens/auth_screen.dart';
import 'package:first_app/screens/firstpage_screen.dart';
import 'package:first_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/screens/home_screen.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dbce',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Color(0xff796A92),
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Color(0xff796A92),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              return HomeScreen(); //first page
              //if the user is already loged in then he goes to home page

            }
            return AuthScreen();
            //if the token expired then welcome page
          }),
    );
  }
}
