import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../../preview_event/widgets/videos_list_screen.dart';
import '../../consts/app_screen_size.dart';
import '../../consts/color_const.dart';
import '../../consts/string_consts.dart';
import '../../util_functions/decoration_functions.dart';
import '../cached_image.dart';
import '../custom_photo_view.dart';

class PostWidget extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final List<String>? postImageUrl;
  final List<String>? videoUrl;
  final String caption;
  final int likes;
  final bool canDelete;
  final Function onDelete;

  PostWidget({
    required this.profileImageUrl,
    required this.username,
    this.postImageUrl,
    this.videoUrl,
    required this.caption,
    required this.likes,
    required this.onDelete,
    required this.canDelete,
  });

  @override
  Widget build(BuildContext context) {
    return true
        ? getView()
        : Card(
            elevation: 5,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(CustomPhotoView(imageUrl: profileImageUrl));
                          },
                          child: Container(
                              height: screenHeight * 0.05,
                              width: screenHeight * 0.05,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: cachedImage(imageUrl: profileImageUrl))),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          username.capitalizeFirst.toString(),
                          style: textStyleAbhayaLibre(color: Colors.black),
                        ),
                        const Spacer(),
                        canDelete
                            ? GestureDetector(
                                onTap: () => onDelete(),
                                child: const Icon(
                                  Icons.delete,
                                  color: errorColor,
                                  size: 30,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),

                  if (postImageUrl != null)
                    Visibility(
                      visible: postImageUrl!.isNotEmpty,
                      child: FlutterCarousel(
                        items: postImageUrl
                            ?.map(
                              (url) => GestureDetector(
                                onTap: () {
                                  Get.to(CustomPhotoView(
                                    imageUrl: url,
                                  ));
                                },
                                child: Container(
                                  width: screenWidth,
                                  child: cachedImage(imageUrl: url),
                                ),
                              ),
                            )
                            .toList(),
                        options: FlutterCarouselOptions(
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          disableCenter: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          viewportFraction: 1,
                          indicatorMargin: 12.0,
                          height: screenHeight * 0.35,
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          enableInfiniteScroll: false,
                          showIndicator: true,
                          slideIndicator: CircularSlideIndicator(
                            slideIndicatorOptions: SlideIndicatorOptions(
                                indicatorRadius: 5,
                                currentIndicatorColor: primaryColor.withOpacity(0.7),
                                alignment: Alignment.bottomCenter,
                                indicatorBackgroundColor: Colors.white),
                          ),
                        ),
                      ),
                    ),

                  // Post actions and caption
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: errorColor,
                              size: 30,
                            ),
                            videoUrl != null && videoUrl!.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => VideosListScreen(
                                                videosList: videoUrl ?? [],
                                              ),
                                          transition: Transition.cupertino);
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        decoration:
                                            BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.video_collection_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.02,
                                            ),
                                            Text(
                                              'View videos',
                                              style: textStyleAbel(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          caption,
                          style: textStyleAbhayaLibre(color: darkGreyColor, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget getView() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (postImageUrl != null)
              Stack(
                children: [
                  Visibility(
                    visible: postImageUrl!.isNotEmpty,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      child: FlutterCarousel(
                        items: postImageUrl
                            ?.map(
                              (url) => GestureDetector(
                                onTap: () {
                                  Get.to(CustomPhotoView(
                                    imageUrl: url,
                                  ));
                                },
                                child: Container(
                                  width: screenWidth,
                                  child: cachedImage(imageUrl: url),
                                ),
                              ),
                            )
                            .toList(),
                        options: FlutterCarouselOptions(
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          disableCenter: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          viewportFraction: 1,
                          indicatorMargin: 12.0,
                          height: screenHeight * 0.3,
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          enableInfiniteScroll: false,
                          showIndicator: true,
                          slideIndicator: CircularSlideIndicator(
                            slideIndicatorOptions: SlideIndicatorOptions(
                                indicatorRadius: 5,
                                currentIndicatorColor: primaryColor.withOpacity(0.7),
                                alignment: Alignment.bottomCenter,
                                indicatorBackgroundColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    //   gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                    //     darkGreyColor.withOpacity(0.6),
                    //     darkGreyColor.withOpacity(0.4),
                    //     darkGreyColor.withOpacity(0.2),
                    //   ]),),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(CustomPhotoView(imageUrl: profileImageUrl));
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: cachedImage(imageUrl: profileImageUrl))),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          username.capitalizeFirst.toString(),
                          style: textStyleAbhayaLibre(color: Colors.white, fontSize: 20),
                        ),
                        const Spacer(),
                        canDelete
                            ? CircleAvatar(
                                backgroundColor: Colors.white,

                                child: GestureDetector(
                                  onTap: () => onDelete(),
                                  child: const Icon(
                                    Icons.delete,
                                    color: errorColor,
                                    size: 20,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: errorColor,
                        size: 30,
                      ),
                      videoUrl != null && videoUrl!.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => VideosListScreen(
                                          videosList: videoUrl ?? [],
                                        ),
                                    transition: Transition.cupertino);
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.video_collection_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      Text(
                                        'Videos',
                                        style: textStyleAbel(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ReadMoreText(
                    caption,
                    trimMode: TrimMode.Line,
                    trimLines: 4,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: '  Show less',
                    style: textStyleAbhayaLibre(color: darkGreyColor, fontSize: 18),
                    moreStyle: const TextStyle(color: Colors.blue),
                    lessStyle: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
