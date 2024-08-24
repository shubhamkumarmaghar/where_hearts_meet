import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import '../../../../utils/widgets/util_widgets/instagram_post_screen.dart';
import '../../../utils/consts/string_consts.dart';
import '../../../utils/util_functions/decoration_functions.dart';
import '../../guest_home/controller/guest_home_controller.dart';
import '../controller/WishesController.dart';

class GuestWishList extends StatefulWidget {
  GuestWishList({
    Key? key,
  }) : super(key: key);

  @override
  _GuestWishListState createState() => _GuestWishListState();
}

class _GuestWishListState extends State<GuestWishList> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuestWishesController>(
        init: GuestWishesController(),
        builder: (controller) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: backgroundGradient,
              ),
              child: Column(
                children: [
                  heightSpace(screenHeight * 0.06),
                  Text(
                    StringConsts.wishes,
                    style: textStyleDangrek(fontSize: 24),
                  ),
                  heightSpace(screenHeight * 0.02),
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.guestWishesModel.length,
                        padding: const EdgeInsets.only(
                          bottom: 15
                        ),
                        separatorBuilder:(context, index) => const SizedBox(height: 15,) ,
                        itemBuilder: (context, index) {
                          var data = controller.guestWishesModel[index];
                          return PostWidget(
                            username: data.senderName ?? '',
                            profileImageUrl: data.senderProfileImage.toString(),
                            likes: 5,
                            postImageUrl: data.imageUrls,
                            videoUrl: data.videoUrls!.isNotEmpty ? data.videoUrls : null,
                            caption: data.senderMessage.toString(),
                            fullDesc: true,
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
