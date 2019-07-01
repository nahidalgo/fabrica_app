import 'package:flutter/material.dart';
import 'PiranguinhoStore.dart';
import 'ItajubaStore.dart';

void main() => runApp(new HomeScreen());

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Fábrica',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: Container(
            color: Colors.white,
            child: Scaffold(
              appBar: AppBar(
                title: Text('App Fábrica'),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Piranguinho',
                        alignLabelWithHint: true,
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a quantidade";
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Itajubá',
                        alignLabelWithHint: true,
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a quantidade";
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    )
                  ],
                ),
              ),
            )));
  }
}
