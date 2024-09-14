import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../player/view/video_player_screen.dart';
import '../../../utils/widgets/circular_dotted_border.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/image_stroy_widget.dart';
import '../guest_home/controller/guest_home_controller.dart';

class TimelineStoriesSreen extends StatefulWidget {
  @override
  _TimelineStoriesSreenState createState() => _TimelineStoriesSreenState();
}

class _TimelineStoriesSreenState extends State<TimelineStoriesSreen> {
  int _currentIndex = 0;
  String showMessage = "";
  final controller = Get.find<GuestHomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
   // controller.countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: backgroundGradient,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heightSpace(screenHeight*0.02),
                  Center(
                    child: Text('Wishes', style: GoogleFonts.dancingScript(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 50),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        GestureDetector(
                          onTap: () {
                            Get.to(() => ImageStoryWidget(
                                  images: controller.timeLineModel.value.images,
                                ));
                          },
                          child: DottedCircularBorder(
                            totalNumber: controller.timeLineModel.value.images != null
                                ? controller.timeLineModel.value.images!.length
                                : 0,
                            dotsColor: Colors.white,
                            widget: Container(
                              height: screenHeight * 0.12,
                              width: screenWidth * 0.22,
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: controller.timeLineModel.value.images != null &&
                                        controller.timeLineModel.value.images!.isNotEmpty
                                    ? Image.network(
                                        controller.timeLineModel.value.images!.first ?? '',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(dummyImage),
                              ),
                            ),
                            radius: screenWidth * 0.09,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 400.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: controller.timeLineModel.value.images?.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(CustomPhotoView(
                                imageUrl: imagePath,
                              ));
                            },
                            child:
                            Container(
                              width: screenWidth,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imagePath),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: screenHeight*0.03),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 400.0,
                      enlargeCenterPage: true,
                      //autoPlay: true,
                     // aspectRatio: 16 / 9,
                     // autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),

                    items: controller.timeLineModel.value.videos?.map((videoPath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return
                            VideoPlayerScreen(url: videoPath);
                        },
                      );
                    }).toList(),
                  ),



                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: controller.homeConfettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              colors: [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.red,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageCard(String title, String imageUrl, String message) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  //color: Colors.transparent
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
