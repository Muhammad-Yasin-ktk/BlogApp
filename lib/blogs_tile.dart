import 'package:flutter/material.dart';

class BlogsTile extends StatelessWidget {
  String imageUrl, title, desc, autherName;

  BlogsTile({this.imageUrl, this.desc, this.title, this.autherName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 13),
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(

                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23,),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  autherName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(desc),
              ],
            ),
          )
        ],
      ),
    );
  }
}
