import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/guest_dashboard/personal_wishes/view/personal_wishes.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';

import '../../../utils/consts/color_const.dart';
import '../../../utils/consts/images_const.dart';
import '../../../utils/util_functions/decoration_functions.dart';

class GetPersonalScreenCover extends StatefulWidget {
  const GetPersonalScreenCover({super.key});

  @override
  State<GetPersonalScreenCover> createState() => _GetPersonalScreenCoverState();
}

class _GetPersonalScreenCoverState extends State<GetPersonalScreenCover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(su1), fit: BoxFit.fitHeight)),
          ),
          Container(
            width: screenWidth,
            height: screenHeight,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  // appColor3.withOpacity(0.1),
                  primaryColor.withOpacity(0.2),
                  //appColor1.withOpacity(0.8),
                  primaryColor.withOpacity(0.5),
                  primaryColor.withOpacity(0.8),
                  primaryColor,
                  //appColor1,
                ])),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace(screenHeight * 0.5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Explore Special Feelings',
                        style: GoogleFonts.architectsDaughter(
                            fontSize: 45, color: Colors.white)),
                  ),
                ]),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            //left: screenWidth*0.4,
            child: GestureDetector(
              onTap: (() {

                Get.to(const GetPersonalWishScreen());
              }),
              child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1,),
                        color: Colors.white,
                        spreadRadius: 3,
                        blurRadius: 5,
                        blurStyle: BlurStyle.solid,
                      )
                    ],
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Start ',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
