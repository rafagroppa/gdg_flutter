import 'package:app/shared/SmsService.dart';
import 'package:flutter/material.dart';

class AutenticacaoPage extends StatefulWidget {
  @override
  _AutenticacaoPageState createState() => _AutenticacaoPageState();
}

class _AutenticacaoPageState extends State<AutenticacaoPage> {
  String telefone;
  String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Autenticação"),
      ),
      body: Padding(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String value) {
                setState(() {
                 this.telefone = value; 
                });
              },
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20)
                  )
                ),
                filled: true,
                hintStyle:  new TextStyle(color: Colors.grey[800]),
                hintText: "Celular",
                fillColor: Colors.white,

              ),
            ),
            Container(
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),   
              child: FlatButton(
                color: Color(0xff006caa),
                shape: StadiumBorder (),
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),                
                child: Text(
                  "Enviar", 
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),             
                onPressed: () {
                  SmsService s = SmsService();

                  s.enviar(this.telefone);
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Valide o token recebido",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (String value) {
                setState(() {
                  this.token = value;
                });
              },
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20)
                  )
                ),
                filled: true,
                hintStyle:  new TextStyle(color: Colors.grey[800]),
                hintText: "Token de validação",
                fillColor: Colors.white,

              ),
            ),
            Container(
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),   
              child: FlatButton(
                color: Color(0xff006caa),
                shape: StadiumBorder (),
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),                
                child: Text(
                  "Validar", 
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),             
                onPressed: () {
                  SmsService s = SmsService();

                  s.validarToken(this.token);
                },
              ),
            )
          ],
        ), padding: EdgeInsets.all(10),
      ),
    );
  }
}