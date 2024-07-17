import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../video_player.dart';

class PostWidget extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final List<String>? postImageUrl;
  final List<String>? videoUrl;
  final String caption;
  final int likes;

  PostWidget({
    required this.profileImageUrl,
    required this.username,
    this.postImageUrl,
    this.videoUrl,
    required this.caption,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10,
         // horizontal: 10
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                    NetworkImage(profileImageUrl),
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

         if(postImageUrl != null) Visibility(
            visible: postImageUrl!.isNotEmpty,
            child: AspectRatio(
                aspectRatio: 2, // Square aspect ratio for the image
                child: CarouselSlider(
                  items: postImageUrl?.map((url) => Container(
                    width: Get.width,
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ), ).toList(),
                  options: CarouselOptions(
                      //height: Get.height * 0.295,

                      // enlargeCenterPage: true,
                      autoPlay: false,
                      //aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration:
                      Duration(milliseconds: 800),
                      viewportFraction: 1),
                ),

              ),
          ),
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