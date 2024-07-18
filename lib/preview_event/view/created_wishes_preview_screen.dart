import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/preview_event/controller/created_wishes_preview_controller.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/custom_photo_view.dart';

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
        //decoration: BoxDecoration(gradient: backgroundGradient),
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
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wish from ${controller.wishesModel.senderName ?? ''}',
                        style: headingStyle(fontSize: 20),
                      ),
                      Text(
                        getYearTime(controller.eventResponseModel.eventHostDay ?? ''),
                        style: textStyleAbel(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(CustomPhotoView(
                        imageUrl: controller.wishesModel.senderProfileImage,
                      ));
                    },
                    child: Container(
                      height: screenHeight * 0.065,
                      width: screenHeight * 0.065,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: cachedImage(imageUrl: controller.wishesModel.senderProfileImage)),
                    ),
                  ),
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
                  enableInfiniteScroll: true,
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
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
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
              Text(
                // controller.wishesModel.senderMessage ?? '',
                'The Lord of the Rings is a trilogy of epic fantasy adventure films directed by Peter Jackson, based on the novel The Lord of the Rings by British author J. R. R. Tolkien. The films are subtitled The Fellowship of the Ring (2001), The Two Towers (2002), and The Return of the King (2003). Produced and distributed by New Line Cinema with the co-production of WingNut Films, the films feature an ensemble cast including Elijah Wood, Ian McKellen, Liv Tyler, Viggo Mortensen, Sean Astin, Cate Blanchett, John Rhys-Davies, Christopher Lee, Billy Boyd, Dominic Monaghan, Orlando Bloom, Hugo Weaving, Andy Serkis, and Sean Bean.',
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
