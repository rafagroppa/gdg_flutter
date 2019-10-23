import 'package:app/pages/detail/detail.page.dart';
import 'package:app/shared/posts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var client = Dio();
  List<Posts> dados = [];
  
  Future<List<Posts>> _listar() async {
    try {
      List retorno = [];

      var response = await client.get("https://jsonplaceholder.typicode.com/posts");
      if (response.statusCode == 200) {
        retorno = (response.data as List).map((m) => Posts.fromJson(m)).toList();
      }

      

      return retorno;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();

    this._listar().then((m) =>
      setState(() {
        this.dados = m;    
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Lista"),
      ),
      body: ListView.builder(
        itemCount: dados.length,
        itemBuilder: (BuildContext ctxt, int index) {
          var p = dados[index];
          return Card(
            child: new ListTile(
              title: Text(p.title.substring(0, 5)),
              subtitle: Text(p.body.substring(0 , 5)),
              contentPadding: EdgeInsets.all(10),
              leading: Image.network(
                "https://res.cloudinary.com/teepublic/image/private/s--i6udtHvA--/t_Resized%20Artwork/c_fit,g_north_west,h_1054,w_1054/co_ffffff,e_outline:53/co_ffffff,e_outline:inner_fill:53/co_bbbbbb,e_outline:3:1000/c_mpad,g_center,h_1260,w_1260/b_rgb:eeeeee/c_limit,f_jpg,h_630,q_90,w_630/v1532255304/production/designs/2922689_0.jpg",
                fit: BoxFit.cover
              ),
              trailing: Text("2"),
              onLongPress: () {},
              onTap: () {
                Navigator.push(
                  context,              
                  //MaterialPageRoute(builder: (context) => LoginPage()),
                  MaterialPageRoute(builder: (context) => DetailPage(post: p))
                );
              },
            ),
          );
        },
        padding: EdgeInsets.all(10),      
      ),
    );
  }
}