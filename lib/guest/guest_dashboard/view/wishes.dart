import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../guest_home/controller/guest_home_controller.dart';

class BirthdayWishes extends StatefulWidget {
  @override
  _BirthdayWishesState createState() => _BirthdayWishesState();
}

class _BirthdayWishesState extends State<BirthdayWishes> {
  final controller = Get.find<GuestHomeController>();
  void listener() {
    if (controller.isPlayerReady && mounted && !controller.youtubePlayerController.value.isFullScreen) {
      setState(() {
        controller.playerState = controller.youtubePlayerController
            .value.playerState;
        controller.videoMetaData = controller.youtubePlayerController.metadata;
      });
    }
  }
  @override
  void initState() {
    super.initState();

  }



  @override
  void dispose() {
    controller.countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cover photo with countdown
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${controller.eventDetails!.coverPic}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    '${controller.countdownDuration.inDays}d ${controller.countdownDuration.inHours % 24}h ${controller.countdownDuration.inMinutes % 60}m ${controller.countdownDuration.inSeconds % 60}s',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                // Birthday wish widgets
                imageCardWidget(
                  'Happy Birthday!',
                  controller.eventDetails!.imageUrls!.first,
                  controller.eventDetails!.eventSubtext.toString(),
                  //'Wishing you all the best on your special day!',
                ),
                imageCard( 'Happy Birthday!',
                  controller.eventDetails!.imageUrls![1],
                  controller.eventDetails!.eventDescription.toString(),),
                 // 'Wishing you all the best on your special day!',),
                textCardWidget(
                  'Special Day!',
                  'May your birthday be filled with joy and happiness.',
                ),
                quoteCardWidget(
                  'Birthday Quote',
                  '"Count your life by smiles, not tears. Count your age by friends, not years."',
                ),
                // Video play widget
                videoPlayWidget('https://via.placeholder.com/150'),
               // youtubeVideoPlayWidget('nPt8bK2gbaU'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageCardWidget(String title, String imageUrl, String message) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(imageUrl),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 5),
                Text(message),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textCardWidget(String title, String message) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 5),
            Text(message),
          ],
        ),
      ),
    );
  }

  Widget quoteCardWidget(String title, String quote) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 5),
            Text(quote, style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget videoPlayWidget(String videoUrl) {
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
            Container(
              height: 200,
              color: Colors.black12,
              child: Center(
                child: Icon(Icons.play_circle_fill, size: 50, color: Colors.grey),
              ),
            ),
          ],
        ),
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
