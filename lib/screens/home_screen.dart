import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cidadeSelecionada = "Itajubá";

  var _textFieldKey = GlobalKey<FormState>();

  var listaCidades = [
    DropdownMenuItem(
      child: Text("Itajubá", style: TextStyle(color: Colors.black),),
      value: "Itajubá",
    ),
    DropdownMenuItem(
      child: Text("Piranguinho", style: TextStyle(color: Colors.black)),
      value: "Piranguinho",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: DropdownButton(
          items: listaCidades,
          onChanged: (cidade) {
            setState(() {
              cidadeSelecionada = cidade;
            });
          },
          value: cidadeSelecionada,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                key: _textFieldKey,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Entre com a quantidade para $cidadeSelecionada',
                  alignLabelWithHint: true,
                ),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira a quantidade";
                  }
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                child: Text(
                  "ENVIAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_textFieldKey.currentState.validate()) {
                    //TODO : Adicionar quantidades ao banco de dados
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
