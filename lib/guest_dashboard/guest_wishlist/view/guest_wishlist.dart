import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import '../../../../utils/widgets/util_widgets/instagram_post_screen.dart';
import '../../guest_home/controller/guest_home_controller.dart';
import '../controller/WishesController.dart';

class GuestWishList extends StatefulWidget {

   GuestWishList({Key? key,}) : super(key: key);


  @override
  _GuestWishListState createState() => _GuestWishListState();
}

class _GuestWishListState extends State<GuestWishList>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuestWishesController>(
      init:GuestWishesController() ,
      builder: (controller) {
        return Scaffold(
          body: Container(
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
              physics: BouncingScrollPhysics(),
              children: [
                heightSpace(screenHeight*0.02),
                 Center(
                   child: Text('Wishes', style: GoogleFonts.dancingScript(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 50),),
                 ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                 height:Get.height*0.9,
                  width: Get.width,
                  child:    ListView.builder(
                    physics: const BouncingScrollPhysics(),
                  itemCount: controller.guestWishesModel.length,
                    itemBuilder: (context,index) {
                      var data = controller.guestWishesModel[index];
                      return PostWidget(
                        username:data.senderName??'' ,
                        profileImageUrl:data.senderProfileImage.toString()  ,
                        likes: 5,
                        postImageUrl: data.imageUrls,
                        videoUrl: data.videoUrls!.isNotEmpty ?data.videoUrls:null,
                        caption: data.senderMessage.toString(),
                        fullDesc: true,
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}