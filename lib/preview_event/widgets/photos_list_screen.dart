import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/player/view/video_player_screen.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
import 'package:where_hearts_meet/utils/widgets/custom_photo_view.dart';

import '../../utils/util_functions/decoration_functions.dart';

class PhotosListScreen extends StatelessWidget {
  final List<String> photosList;

  const PhotosListScreen({super.key, required this.photosList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.06,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Text(
                  'Photos',
                  style: textStyleDangrek(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: photosList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  var data = photosList[index];

                  return GestureDetector(
                    onTap: () async {
                      Get.to(CustomPhotoView(
                        imageUrl: data,
                      ));
                    },
                    child: SizedBox(
                      height: screenHeight * 0.3,
                      width: screenWidth,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        child: cachedImage(imageUrl: data),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
