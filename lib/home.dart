import 'package:blog_app_crud/PostDetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("post");

  @override
  void initState() {
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.docs;
      });
    });
    super.initState();
  }

  passData(DocumentSnapshot snap) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => postDetails(
          snapshot: snap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter Blog App'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: new Icon(Icons.search),
            onPressed: () => debugPrint('Search'),
          ),
          IconButton(
            icon: new Icon(Icons.add),
            onPressed: () => debugPrint('Add'),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: new Text('Wahid Malik'),
              accountEmail: new Text('wahidmalik551@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: new Text('First Page'),
              leading: new Icon(
                Icons.pages,
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: new Text('Second Page'),
              leading: new Icon(
                Icons.account_box,
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: new Text('Third Page'),
              leading: new Icon(
                Icons.cached,
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: new Text('Fourth Page'),
              leading: new Icon(
                Icons.menu,
                color: Colors.purple,
              ),
            ),
            Divider(
              height: 10.0,
              color: Colors.black,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  leading: Icon(
                    Icons.close,
                    color: Colors.purple,
                  ),
                  title: Text('Close'),
                  //selected: true,
                ),
              ),
            ),
          ],
        ),
      ),
      body: snapshot == null
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10.0,
                  margin: EdgeInsets.all(10.0),
                  child: new Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Text(snapshot[index].data()['title'][0]),
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                            width: 210.0,
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  child: new Text(
                                    snapshot[index].data()['title'],
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 22.0, color: Colors.green),
                                  ),
                                  onTap: () {
                                    passData(snapshot[index]);
                                  },
                                ),
                                new SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  snapshot[index].data()['content'],
                                  maxLines: 2,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
