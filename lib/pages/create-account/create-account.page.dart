import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String email = "";
  String senha = "";
  String nome = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<FirebaseUser> _handleCreateAccount() async {
  //   final AuthResult auth = await _auth.signInWithEmailAndPassword(
  //     email: this.email,
  //     password: this.senha,
  //   );
  //   return auth.user;
  // }

  Future<String> _getURLImagem(String idUsuario) async {
    if (this.file == null) {
      return "";
    }

    String fileName = idUsuario + '-foto.jpg';
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('images/' + fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(this.file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  _createDocumentUsuario(
    String nome, 
    String email, 
    String urlFoto,
    String latitude, 
    String longitude
  ) async {
    final databaseReference = Firestore.instance;
    await databaseReference.collection("users").document(email).setData({
      'nome': nome,
      'email': email,
      'urlFoto': urlFoto,
      'latitude': latitude,
      'longitude': longitude
    });
  }

  Future<FirebaseUser> _handleCreateAccount() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: this.email,
      password: this.senha,
    )).user;

    String urlImage = await this._getURLImagem(user.uid);

    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = nome;
    if (urlImage != "") {
      info.photoUrl = urlImage;
    }
    await user.updateProfile(info);
    await user.reload();

    this._createDocumentUsuario(this.nome, this.email, urlImage, "0", "0");

    return user;
  }

  File file;
  
  _loadImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    
    setState(() {
      file = image;
      //print("Profile Picture uploaded " + downloadUrl);
      //Scaffold.of(context)
      //    .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://i.pinimg.com/originals/fe/e5/ea/fee5eab30a698c169dc4fd5752359c2c.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(            
              child: Center( 

                child: GestureDetector(
                  onTap: () {
                    //Insert event to be fired up when button is clicked here
                    //in this case, this increments our `countValue` variable by one.
                    this._loadImage();
                  },
                  child: this.file == null 
                  ? Image.network(
                   'https://www.fourjay.org/myphoto/f/14/143147_avatar-png.jpg',
                    width: 150,
                    height: 150,
                  ) 
                  : Image.file(
                    this.file,
                    width: 150,
                    height: 150,
                  )
                  // child: Image.network(
                  //   'https://www.fourjay.org/myphoto/f/14/143147_avatar-png.jpg',
                  //   width: 150,
                  //   height: 150,
                  // ),
                )
              ),
              flex: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    //Image.file(file),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          nome = value;
                        },
                        style: TextStyle(fontSize: 15),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "nome",
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        style: TextStyle(fontSize: 15),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "e-mail",
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          senha = value;
                        },
                        obscureText: true,
                        style: TextStyle(fontSize: 15),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "senha",
                            fillColor: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: double.infinity,
                      child: OutlineButton(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                        child: Text(
                          'CREATE',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1),
                        onPressed: () async {
                          try {
                            var user = await _handleCreateAccount();
                            print(user);
                            //var snackBar =
                            //    SnackBar(content: Text('Usuário ' + user.displayName + ' logado!'));
                            //Scaffold.of(context).showSnackBar(snackBar);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                //decoration: BoxDecoration(color: Colors.green),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
