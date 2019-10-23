import 'package:app/shared/posts.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Posts post;

  const DetailPage({Key key, this.post}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Detalhe"),
      ),
      body: Container(
        child: Text(widget.post.body),
        padding: EdgeInsets.all(20),
      ),
    );
  }
}