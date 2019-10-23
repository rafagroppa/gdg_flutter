import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleLogin(String email, String senha) async {
    final AuthResult user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha
    );

    return user.user;
  }

  String email = "";
  String senha = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:  DecorationImage (
            image: NetworkImage("https://androidexample365.com/content/images/2019/03/Android-BackgroundChart.png"),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center (
                child: Image.network(
                  'http://www.vectorico.com/download/social_media/Tinder-Icon.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )
              ),
              flex: 1,            
            ),            
            Expanded (
              flex: 2,
              child: Container (
                child: Column(
                  children: <Widget>[  
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: (
                        TextField(
                          style: TextStyle(fontSize: 15),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (String value) {
                            this.email = value;
                          },
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20)
                              )
                            ),
                            filled: true,
                            hintStyle:  new TextStyle(color: Colors.grey[800]),
                            hintText: "E-mail",
                            fillColor: Colors.white
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: (
                        TextField(
                          style: TextStyle(fontSize: 15),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          onChanged: (String value) {
                            this.senha = value;
                          },
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20)
                              )
                            ),
                            filled: true,
                            hintStyle:  new TextStyle(color: Colors.grey[800]),
                            hintText: "Senha",
                            fillColor: Colors.white
                          ),
                        )
                      ),
                    ),                
                    Container(
                      width: double.infinity,
                      height: 70,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),                                            
                      child: FlatButton (
                        color: Color(0xff006caa),
                        shape: StadiumBorder (),
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),                
                        child: Text(
                          "E-MAIL", 
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: () async {
                          try {
                            var user = await this._handleLogin(this.email, this.senha);
                            //print(user);

                            final snackBar = SnackBar(content: Text('Usuário logado com sucesso'));
                            Scaffold.of(context).showSnackBar(snackBar);                            
                          } catch(e) {

                            print(e);
                          }                          
                        },
                      ),
                    ),
                  ]
                )
              )
            )            
          ],
        ),
      )
    );
  }
}