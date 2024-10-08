import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/widgets/custom_photo_view.dart';

import '../../../preview_event/widgets/videos_list_screen.dart';
import '../../consts/color_const.dart';
import '../../util_functions/decoration_functions.dart';

class PostWidget extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final List<String>? postImageUrl;
  final List<String>? videoUrl;
  final String caption;
  final int likes;
  final bool? fullDesc;

  PostWidget({
    required this.profileImageUrl,
    required this.username,
    this.postImageUrl,
    this.videoUrl,
    required this.caption,
    required this.likes,
    this.fullDesc

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
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
                  GestureDetector(
                    onTap: () {
                      Get.to(CustomPhotoView(imageUrl: profileImageUrl));
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profileImageUrl),
                      radius: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
            ),

            if (postImageUrl != null)
              Visibility(
                visible: postImageUrl!.isNotEmpty,
                child: CarouselSlider(
                  items: postImageUrl
                      ?.map(
                        (url) => GestureDetector(
                          onTap: () {
                            Get.to(CustomPhotoView(
                              imageUrl: url,
                            ));
                          },
                          child:
                          Container(
                            width: screenWidth,
                            child: Image.network(
                              url,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                      height: Get.height * 0.4,

                      // enlargeCenterPage: true,
                      autoPlay: false,
                      //aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1),
                ),
              ),
            // Post actions and caption
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 10),
                          Text('$likes likes'),
                        ],
                      ),
                      fullDesc==true ?GestureDetector(
                        onTap:() {
                          Get.to(
                                  () => VideosListScreen(
                                videosList: videoUrl ?? [],
                              ),
                              transition: Transition.cupertino
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration:
                            BoxDecoration(color: primaryColor.withOpacity(0.2), borderRadius: BorderRadius.circular(5)),
                            width: screenWidth * 0.35,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.video_collection_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Text(
                                  'View videos',
                                  style: textStyleAbel(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ):const SizedBox(),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                      constraints: fullDesc==true ? null:BoxConstraints(maxHeight: Get.height * 0.1),
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
