import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BirthdayWishes extends StatefulWidget {
  @override
  _BirthdayWishesState createState() => _BirthdayWishesState();
}

class _BirthdayWishesState extends State<BirthdayWishes> {
  DateTime birthday = DateTime(2024, 7, 20); // Set your birthday date here
  Duration countdownDuration = Duration();
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    countdownDuration = birthday.difference(DateTime.now());
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        countdownDuration = birthday.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
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
                    image: NetworkImage('https://via.placeholder.com/500'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    '${countdownDuration.inDays}d ${countdownDuration.inHours % 24}h ${countdownDuration.inMinutes % 60}m ${countdownDuration.inSeconds % 60}s',
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
                  'https://via.placeholder.com/300',
                  'Wishing you all the best on your special day!',
                ),
                imageCard( 'Happy Birthday!',
                  'https://via.placeholder.com/300',
                  'Wishing you all the best on your special day!',),
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
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
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
