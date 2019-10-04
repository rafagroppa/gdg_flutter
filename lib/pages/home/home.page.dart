import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                          "LOGIN WITH FACEBOOK", 
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: () async {
                          LocationData currentLocation;

                          var location = new Location();

                          // Platform messages may fail, so we use a try/catch PlatformException.
                          try {
                            currentLocation = await location.getLocation();
                            print(currentLocation.latitude);
                            print(currentLocation.longitude);
                          } on Exception catch (e) {
                            // if (e.code == 'PERMISSION_DENIED') {
                            //   error = 'Permission denied';
                            // } 
                            print(e);
                            currentLocation = null;
                          }
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
                          "LOGIN WITH PHONE NUMBER", 
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
                        onPressed: () {},
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