import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class postDetails extends StatefulWidget {
  DocumentSnapshot snapshot;
  postDetails({this.snapshot});

  @override
  _postDetailsState createState() => _postDetailsState();
}

class _postDetailsState extends State<postDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
        backgroundColor: Colors.green,
      ),
      body: Card(
        elevation: 10.0,
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  new CircleAvatar(
                    child: new Text(widget.snapshot.data()['title'][0]),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  new Text(
                    widget.snapshot.data()['title'],
                    style: TextStyle(fontSize: 22.0, color: Colors.green),
                  ),
                ],
              ),
            ),
            new SizedBox(
              height: 10.0,
            ),
            new Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                widget.snapshot.data()['content'],
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
