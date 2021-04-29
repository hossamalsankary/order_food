import 'package:flutter/material.dart';
import 'package:order/screens/cart_screen.dart';
import 'package:order/screens/homeScreen/home_screen.dart';
import 'package:order/screens/welcom_screen.dart';
import 'package:order/widgets/food_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Collecting(
      child: MaterialApp(
        title: 'Flutter Food Delivery UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //S1 change bakground

          primaryColor: Color(0xFFffffff),
          accentColor: Color(0xFFf0f0f0),
        ),
        //home: HomeScreen(),
        initialRoute: "welcome",
        routes: {
          "home": (_) => HomeScreen(),
          "card": (_) => CartScreen(),
          "welcome": (_) => WelcomeScreen(),
        },
      ),
    );
  }
}
