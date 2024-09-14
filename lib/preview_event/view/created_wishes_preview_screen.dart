import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/pop_up_menus.dart';
import '../controller/created_wishes_preview_controller.dart';

class CreatedWishesPreviewScreen extends StatelessWidget {
  final controller = Get.find<CreatedWishesPreviewController>();

  CreatedWishesPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Wish',
                    style: textStyleDangrek(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(CustomPhotoView(
                        imageUrl: controller.wishesModel.senderProfileImage,
                      ));
                    },
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenHeight * 0.06,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: cachedImage(imageUrl: controller.wishesModel.senderProfileImage)),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.wishesModel.senderName ?? '',
                        style: textStyleDangrek(fontSize: 20),
                      ),
                      Text(
                        getYearTime(controller.eventResponseModel.eventHostDay ?? ''),
                        style: textStyleAbel(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Spacer(),
                  moreViewPopUpMenu(showBackground: false, onDelete: controller.deleteWish),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: screenHeight * 0.25,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: false,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                  viewportFraction: 1,
                ),
                items: controller.wishesModel.imageUrls?.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(CustomPhotoView(
                            imageUrl: imagePath,
                          ));
                        },
                        child: Container(
                          width: screenWidth,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Visibility(
                visible: controller.wishesModel.videoUrls != null && controller.wishesModel.videoUrls!.isNotEmpty,
                replacement: const SizedBox.shrink(),
                child: GestureDetector(
                  onTap: controller.navigateToVideosListScreen,
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
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                controller.wishesModel.senderMessage ?? '',
                style: textStyleAbel(fontSize: 18),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
