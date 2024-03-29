import 'dart:io';

import 'package:app/pages/autenticacao/autenticacao.page.dart';
import 'package:app/pages/create-account/create-account.page.dart';
import 'package:app/pages/list/list.page.dart';
import 'package:app/pages/login/login.page.dart';
import 'package:app/shared/Message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();

    FirebaseCloudMessaging_Listeners();
  }

  void FirebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) IosPermission();

    _firebaseMessaging.getToken().then((token) {
      print("######token#######");
      print(token);
      print(token);
      print(token);
      print(token);
      print(token);
      print(token);
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        final notification = message["notification"];
        messages.add(Message(
          title: notification["title"],
          body: notification["body"],
        ));
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void IosPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }


  Future<FirebaseUser> _handleCreateUser() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: "rafagroppa@gmail.com",
      password: "ronaldo"
    )).user;

    return user;
  }

  Future<FirebaseUser> _handleLogin() async {
    final AuthResult user = await _auth.signInWithEmailAndPassword(
      email: "rafagroppa@gmail.com",
      password: "ronaldo"
    );

    return user.user;
  }

  void _ronaldo() {

  }

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
              flex: 3,            
            ),
            Expanded(
              child: Container (
                child: Column(
                  children: <Widget>[
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
                          "LOGIN WITH E-MAIL", 
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,              
                          //   //MaterialPageRoute(builder: (context) => LoginPage()),
                          //   //MaterialPageRoute(builder: (context) => ListPage())
                          //   MaterialPageRoute(builder: (context) => AutenticacaoPage())                    
                          // );

                          this._ronaldo();
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 65,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: OutlineButton (
                        shape: StadiumBorder (),
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),                
                        child: Text(
                          "CADASTRO", 
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2
                        ),
                        onPressed: () async {
                          //await _handleLogin();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateAccountPage()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              flex: 2,
            ),
            Expanded (
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Terms",
                  style: TextStyle (
                  color: Colors.white,
                  fontSize: 20
                ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}