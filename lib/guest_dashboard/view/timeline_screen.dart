import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/custom_photo_view.dart';
import 'package:where_hearts_meet/utils/widgets/image_stroy_widget.dart';

import '../../../player/view/video_player_screen.dart';
import '../../../utils/widgets/circular_dotted_border.dart';
import '../guest_home/controller/guest_home_controller.dart';

class TimelineStoriesSreen extends StatefulWidget {
  @override
  _TimelineStoriesSreenState createState() => _TimelineStoriesSreenState();
}

class _TimelineStoriesSreenState extends State<TimelineStoriesSreen> {
  String message = '''Happy Birthday rashi🎉
              
                    I wanted to take a moment to celebrate not only your special day but also the incredible year we’ve shared together. It’s hard to believe it’s been a whole year since we started this journey as roommates, lab partners, and “sukh dukh ka saathi.”
              
                  From the countless lab sessions to the spontaneous adventures and heartfelt conversations, every moment has been amazing. Your kindness, support, and genuine heart have made this past year truly special. You’ve been a rock in times of stress and a joy in times of celebration.
              
                  I’m grateful for your friendship and the beautiful memories we’ve created together. I sincerely hope that our bond continues to grow stronger with each passing year. Here’s to many more adventures, laughs, and unforgettable moments together!
              
                    Wishing you all the happiness, love, and success in the world on your birthday and always.''';
  String showMessage = "";
  final controller = Get.find<GuestHomeController>();

  @override
  void initState() {
    textAnimation();
    super.initState();
  }

  @override
  void dispose() {
    controller.countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> textAnimation() async {
    String? text = message;

    List<String>? wordsList = text?.split('');

    for (var word in wordsList!) {
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() {
        showMessage = showMessage + word;
      });
    }
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
                  heightSpace(30),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.07,
                          backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/where-hearts-meet.appspot.com/o/WhatsApp%20Image%202024-07-17%20at%2023.36.03_5909fd2b.jpg?alt=media&token=ef1eb0ea-8b8b-43a0-921a-a9e5ae4c12eb"),
                        ),
                        widthSpace(20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.eventDetails!.hostName ?? controller.eventDetails!.hostName.toString(),
                              style: GoogleFonts.abel(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24),
                            ),
                            Text(
                              '@sunandaaryan',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70),
                            ),
                          ],
                        ),
                        Spacer(),
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
                  VideoPlayerScreen(url: controller.videoUrl),
                  SizedBox(height: screenHeight*0.03),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Text(
                      showMessage,
                      textAlign: TextAlign.center,

                      style: textStyleDangrek(fontSize: 18,fontWeight: FontWeight.w300),
                    ),
                  ),

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
                            child: Container(
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
