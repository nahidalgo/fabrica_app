import 'package:fabrica_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'PiranguinhoStore.dart';
import 'ItajubaStore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Fábrica',
        theme: ThemeData(
          primaryColor: Colors.red[800],
          accentColor: Color.fromRGBO(142, 0, 0, 255),
          buttonTheme: ButtonThemeData(
            alignedDropdown: true,
            buttonColor: Colors.red[800],
            height: 48
          ),
          //canvasColor: Color.fromRGBO(255, 95, 82, 255),
          textTheme: TextTheme(
            button: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            subhead: TextStyle( fontSize: 18),

          )
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        );
  }
}
