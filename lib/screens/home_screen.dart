import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var db = Firestore.instance;

class _HomeScreenState extends State<HomeScreen> {
  var cidadeSelecionada = "Itajubá";

  var _textFieldKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var _quantityController = TextEditingController();

  var listaCidades = [
    DropdownMenuItem(
      child: Text(
        "Itajubá"
      ),
      value: "Itajubá",
    ),
    DropdownMenuItem(
      child: Text("Piranguinho"
      ),
      value: "Piranguinho",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              SizedBox(height: 57,),
              Image.asset("images/logo.png", fit: BoxFit.fitHeight, height: 100,),
              SizedBox(height: 29),
              TextFormField(
                controller: _quantityController,
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
                onPressed: () async {
                    var doc = await db
                        .collection(cidadeSelecionada)
                        .document("EmpadasCruas")
                        .get();
                    var novaQuantidade = doc.data['quantidade'] +
                        int.parse(_quantityController.text);

                    db
                        .collection(cidadeSelecionada)
                        .document("EmpadasCruas")
                        .updateData({"quantidade": novaQuantidade}).then((_) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text("Enviado com sucesso!"),
                        ),
                      );
                    }).catchError((_) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text("Erro ao enviar"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                    setState(() {
                      _quantityController.text = '';
                    },
                    );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
