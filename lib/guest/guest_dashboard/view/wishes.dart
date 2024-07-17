import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/widgets/custom_photo_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../guest_home/controller/guest_home_controller.dart';

class GuestTimeLine extends StatefulWidget {
  @override
  _GuestTimeLineState createState() => _GuestTimeLineState();
}

class _GuestTimeLineState extends State<GuestTimeLine> {
  String message = '''Happy Birthday rashi🎉
              
                    I wanted to take a moment to celebrate not only your special day but also the incredible year we’ve shared together. It’s hard to believe it’s been a whole year since we started this journey as roommates, lab partners, and “sukh dukh ka saathi.”
              
                  From the countless lab sessions to the spontaneous adventures and heartfelt conversations, every moment has been amazing. Your kindness, support, and genuine heart have made this past year truly special. You’ve been a rock in times of stress and a joy in times of celebration.
              
                  I’m grateful for your friendship and the beautiful memories we’ve created together. I sincerely hope that our bond continues to grow stronger with each passing year. Here’s to many more adventures, laughs, and unforgettable moments together!
              
                    Wishing you all the happiness, love, and success in the world on your birthday and always.''';
  String showMessage="";
  final controller = Get.find<GuestHomeController>();

  void listener() {
    if (controller.isPlayerReady && mounted &&
        !controller.youtubePlayerController.value.isFullScreen) {
      setState(() {
        controller.playerState = controller.youtubePlayerController
            .value.playerState;
        controller.videoMetaData = controller.youtubePlayerController.metadata;
      });
    }
  }

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
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff9467ff),
                      Color(0xffae8bff),
                      Color(0xffc7afff),
                      Color(0xffdfd2ff),
                      Color(0xfff2edff),
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heightSpace(30),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(rashi1),
                        ),
                        widthSpace(20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sunanda',
                              style: GoogleFonts.abel(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24),
                            ),
                            Text(
                              '@sunandaaryan',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  Text(
                    showMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
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
                    items:controller.timeLineModel.value.data?[0].images?.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: (){
                              Get.to(CustomPhotoView(imageUrl: imagePath,));
                            },
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
  Widget youtubeVideoPlayWidget(String videoUrl) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Birthday Video',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            YoutubePlayer(
              controller: controller.youtubePlayerController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                controller.youtubePlayerController.addListener(listener);
              },
            ),
          ],
        ),
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
                    colors: [Colors.black.withOpacity(0.5),
                      Colors.transparent],
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


