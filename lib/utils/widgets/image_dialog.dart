import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../consts/color_const.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key, required this.onCameraClicked, required this.onGalleryClicked}) : super(key: key);

  final Function onCameraClicked;
  final Function onGalleryClicked;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Upload Image',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: whiteColor),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        onCameraClicked();
                        Get.back();
                      },
                      child: Container(
                          height: 90,
                          width: 90,
                          child: CircleAvatar(
                              backgroundColor: whiteColor,
                              child: Icon(
                                Icons.camera_alt,
                                size: 35,
                              ))),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: whiteColor),
                    ),
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        onGalleryClicked();
                        Get.back();
                      },
                      child: Container(
                          height: 90,
                          width: 90,
                          child: CircleAvatar(
                              backgroundColor: whiteColor,
                              child: Icon(
                                Icons.camera,
                                size: 35,
                              ))),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: whiteColor),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
