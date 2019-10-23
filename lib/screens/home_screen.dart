import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var db = Firestore.instance;

class _HomeScreenState extends State<HomeScreen> {
  var cidadeSelecionada = "Itajubá";
  var saborSelecionado = "Frango";
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
   var listaSabores = [
      DropdownMenuItem(
        child: Text(
          "Frango"
        ),
        value: "Frango",
      ),
       DropdownMenuItem(
        child: Text(
          "Queijo"
        ),
        value: "Queijo",
      ),
       DropdownMenuItem(
        child: Text(
          "Palmito"
        ),
        value: "Palmito",
      ),
       DropdownMenuItem(
        child: Text(
          "Presunto"
        ),
        value: "Presunto",
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
              SizedBox(height: 15.0,),
              Image.asset("images/logo.png", fit: BoxFit.fitHeight, height: 100,),
               Center(
                 child:
                    DropdownButton(

                      items: listaSabores,
                      onChanged: (sabor) {
                        setState(() {
                          saborSelecionado = sabor;
                        });
                      },
                      value: saborSelecionado,
                    ), 
              ),                
              SizedBox(height: 2.0),
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
                        .collection("Empada")
                        .document(saborSelecionado)
                        .get();

                    var novaQuantidade = doc.data['quantidade'] +
                        int.parse(_quantityController.text);


                    db
                        .collection(cidadeSelecionada)
                        .document("EmpadasCruas")
                        .collection("Empada")
                        .document(saborSelecionado)
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
