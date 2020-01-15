import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() {
  /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark
  ));*/
  runApp(MaterialApp(
    theme: ThemeData(
      cursorColor: Colors.grey,
      textSelectionColor: Colors.grey[350],
      textSelectionHandleColor: Colors.green,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateIMC() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if(imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 29.9) {
        _infoText = "Levemente acima do Peso (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      }
      else {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.green),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(           
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 20),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    )
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromRGBO(80, 80, 80, 1), fontSize: 25),
                  controller: weightController,
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Insira seu peso.";
                    }
                    else if(double.parse(value) <= 0.0) {
                      return "Insira o peso corretamente.";
                    }
                  },
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green, fontSize: 20),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  )
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(80, 80, 80, 1), fontSize: 25),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira sua altura";
                  }
                  else if(double.parse(value) < 0.0) {
                    return "Insira a altura corretamente.";
                  }
                },
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 25),
                  child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        _calculateIMC();
                      } 
                    },
                    child: Text(
                      "Calcular", 
                      style: TextStyle(color: Colors.white, fontSize: 20),),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
              )
            ],
          ),
        ),
      )
    );
  }
}
