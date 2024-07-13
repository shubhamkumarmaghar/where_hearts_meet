import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class PostWidget extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String? postImageUrl;
  final String caption;
  final int likes;

  PostWidget({
    required this.profileImageUrl,
    required this.username,
     this.postImageUrl,
    required this.caption,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
       // width: Get.width*0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                    AssetImage(profileImageUrl),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

           // if(postImageUrl != '') AspectRatio(
           //    aspectRatio: 2, // Square aspect ratio for the image
           //    child: Image.asset(
           //      postImageUrl!,
           //      fit: BoxFit.cover,
           //    ),
           //  ),
            // Post actions and caption
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 10),
                      Text('$likes likes'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: Get.height*0.1
                    ),
                      child: Text(caption)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}