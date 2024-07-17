import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import '../../../../utils/widgets/util_widgets/instagram_post_screen.dart';
import '../../guest_home/controller/guest_home_controller.dart';

class GuestWishList extends StatefulWidget {
  final String title;
   GuestWishList({Key? key, required this.title}) : super(key: key);


  @override
  _GuestWishListState createState() => _GuestWishListState();
}

class _GuestWishListState extends State<GuestWishList>
    with TickerProviderStateMixin {
  final controller = Get.find<GuestHomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
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
        child: ListView(
          children: [
            heightSpace(screenHeight*0.02),
             Center(
               child: Text('Wishes', style: GoogleFonts.dancingScript(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 50),),
             ),
            Container(
              padding: const EdgeInsets.all(16.0),
             height:Get.height*0.9,
              width: Get.width,
              child:    ListView.builder(
              itemCount: controller.guestwishesModel.value.data?.length,
                itemBuilder: (context,index) {
                  var data = controller.guestwishesModel.value.data?[index];
                  return PostWidget(
                    username:data!.senderName??'' ,
                    profileImageUrl:data.senderProfileImage.toString()  ,
                    likes: 5,
                    postImageUrl: data.imageUrls,
                    caption: data.senderMessage.toString(),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}