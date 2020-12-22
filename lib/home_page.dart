import 'package:blog_app/blogs_tile.dart';
import 'package:blog_app/creat_blog.dart';
import 'package:blog_app/service/crud_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = CrudMethods();
  var querySnapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crudMethods.getData().then((value) {
      querySnapshot = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flotter ',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: querySnapshot,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final blogData = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: blogData.length,
                    itemBuilder: (ctx, index) {
                      return BlogsTile(
                        imageUrl: blogData[index]['image_url'],
                        title: blogData[index]['title'],
                        desc: blogData[index]['desc'],
                        autherName: blogData[index]['authername'],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => CreateBlog()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
