import 'package:get/get.dart';
import 'package:scratcher/widgets.dart';
import 'package:flutter/material.dart';
import '../../create_event/model/gift_model.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/confetti_shape_enum.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/app_bar_widget.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/confetti_view.dart';
import '../controller/created_gifts_preview_controller.dart';
import '../widgets/photos_list_screen.dart';

class CreatedGiftsPreviewScreen extends StatelessWidget {
  const CreatedGiftsPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatedGiftsPreviewController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(gradient: backgroundGradient),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.07,
                    ),
                    Row(
                      children: [
                        backIcon(),
                        const Spacer(),
                        Text(
                          StringConsts.eGifts,
                          style: textStyleDangrek(fontSize: 24),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    controller.giftsList.isNotEmpty
                        ? Text(
                            StringConsts.scratchToOpen,
                            style: textStyleMontserrat(fontSize: 16),
                          )
                        : const SizedBox.shrink(),
                    Expanded(child: scratchGiftsWidget(controller)),
                  ],
                ),
                ConfettiView(
                  controller: controller.confettiController,
                  confettiShapeEnum: ConfettiShapeEnum.drawStar,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget scratchGiftsWidget(CreatedGiftsPreviewController controller) {
    return ListView.separated(
        padding: EdgeInsets.only(
          bottom: screenHeight * 0.03,
          top: screenHeight * 0.02,
        ),
        itemBuilder: (context, index) {
          var data = controller.giftsList[index];
          return data.hasOpened
              ? giftWidget(data, true)
              : ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Scratcher(
                      brushSize: 50,
                      threshold: 50,
                      color: primaryColor,
                      image: Image.asset(
                        giftScratchIcon,
                        fit: BoxFit.cover,
                      ),
                      onChange: (value) => controller.onScratch(scratched: value, index: index),
                      child: giftWidget(data, false)),
                );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemCount: controller.giftsList.length ?? 0);
  }

  Widget giftWidget(GiftModel data, bool hasOpened) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.white),
            right: BorderSide(width: 0.5, color: Colors.white),
            top: BorderSide(width: 0.5, color: Colors.white),
            bottom: BorderSide(color: Colors.white, width: 5),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
                width: screenHeight * 0.1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: cachedImage(imageUrl: data.giftLogo),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.54,
                    child: Text(
                      '${StringConsts.from} - ${data.senderName}',
                      style: textStyleAleo(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.54,
                    child: Text(
                      '${StringConsts.gift} - ${data.giftTitle != null ? data.giftTitle.toString().capitalizeFirst : ''}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleAleo(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: data.giftImages != null && data.giftImages!.isNotEmpty,
                      replacement: const SizedBox.shrink(),
                      child: GestureDetector(
                        onTap: () {
                          if (hasOpened) {
                            Get.to(() => PhotosListScreen(photosList: data.giftImages ?? []),
                                transition: Transition.cupertino);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015, horizontal: screenWidth * 0.03),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.photo_library_rounded,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Text(
                                StringConsts.viewPhotos,
                                style: textStyleAbel(fontSize: 16, color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Visibility(
            visible: data.cardId != null && data.cardId!.isNotEmpty,
            child: Text(
              '${StringConsts.giftCardNo} - ${data.cardId}',
              style: textStyleAleo(fontSize: 16),
            ),
          ),
          Visibility(
            visible: data.cardPin != null && data.cardPin!.isNotEmpty,
            child: Text(
              '${StringConsts.giftPin} - ${data.cardPin}',
              style: textStyleAleo(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
