import 'dart:io';
import 'package:blog_app/service/crud_method.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String autherName, title, desc;
  File selectedImage;
  bool isLoading = false;

  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);

    setState(() {
      selectedImage = pickedFile;
    });
  }

  _uploadImage() async {
    if (selectedImage != null) {
      setState(() {
        isLoading = true;
      });
      final ref = FirebaseStorage.instance
          .ref()
          .child('blogImage')
          .child("${randomAlphaNumeric(9)}.jpg");
      UploadTask uploadTask = ref.putFile(selectedImage);

      var dowurl = await (await uploadTask).ref.getDownloadURL();
      print(dowurl);
      Map<String, String> blogMap = {
        'image_url': dowurl,
        'authername': autherName,
        'title': title,
        'desc': desc
      };

      crudMethods.addData(blogMap).then((value) => Navigator.of(context).pop());
    }
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
        actions: [
          GestureDetector(
            onTap: _uploadImage,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.upload_rounded)),
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: getImage,
                    child: selectedImage != null
                        ? Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.file(
                                selectedImage,

                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black87,
                              size: 30,
                            ),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)),
                          ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Auther Name'),
                    onChanged: (val) {
                      autherName = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Title'),
                    onChanged: (val) {
                      title = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Description'),
                    onChanged: (val) {
                      desc = val;
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
