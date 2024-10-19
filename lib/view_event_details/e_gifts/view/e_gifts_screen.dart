import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scratcher/scratcher.dart';

import '../../../create_event/model/gift_model.dart';
import '../../../preview_event/widgets/photos_list_screen.dart';
import '../../../utils/consts/app_screen_size.dart';
import '../../../utils/consts/color_const.dart';
import '../../../utils/consts/confetti_shape_enum.dart';
import '../../../utils/consts/images_const.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/string_consts.dart';
import '../../../utils/dialogs/pop_up_dialogs.dart';
import '../../../utils/shimmers/gift_shimmer.dart';
import '../../../utils/util_functions/decoration_functions.dart';
import '../../../utils/widgets/app_bar_widget.dart';
import '../../../utils/widgets/cached_image.dart';
import '../../../utils/widgets/confetti_view.dart';
import '../../../utils/widgets/no_data_screen.dart';
import '../controller/e_gifts_controller.dart';

class EGiftsScreen extends StatelessWidget {
  final controller = Get.find<EGiftsController>();

  EGiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EGiftsController>(
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
                      height: screenHeight * 0.06,
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
                        controller.canUpdateGift
                            ? GestureDetector(
                                onTap: controller.navigateToAddGifts,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.add,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    // controller.loadingState == LoadingState.hasData
                    //     ? Text(
                    //         StringConsts.scratchToOpen,
                    //         style: textStyleMontserrat(fontSize: 16),
                    //       )
                    //     : const SizedBox.shrink(),
                    Expanded(
                        child: controller.loadingState == LoadingState.loading
                            ? const GiftShimmer()
                            : controller.loadingState == LoadingState.noData
                                ? const NoDataScreen(
                                    showBackIcon: false,
                                    message: 'No any gifts found.',
                                  )
                                : scratchGiftsWidget(controller)),
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

  Widget scratchGiftsWidget(EGiftsController controller) {
    return ListView.separated(
        padding: EdgeInsets.only(
          bottom: screenHeight * 0.03,
          top: screenHeight * 0.02,
        ),
        itemBuilder: (context, index) {
          var data = controller.giftsList![index];
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
        itemCount: controller.giftsList?.length ?? 0);
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
                      maxLines: 2,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
              controller.canUpdateGift
                  ? GestureDetector(
                      onTap: () {
                        showCupertinoActionSheetOptions(
                          button1Text: StringConsts.deleteThisGift,
                          onTapButton1: () {
                            controller.deleteGift(data);
                          },
                        );
                      },
                      child: const Icon(
                        Icons.delete,
                        color: errorColor,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
