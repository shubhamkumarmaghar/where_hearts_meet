import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/widgets/base_container.dart';
import '../controller/event_list_controller.dart';

class EventListScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<EventListController>();

  EventListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Events')),
      body: BaseContainer(
        child: GetBuilder<EventListController>(
          builder: (controller) {
            return Container(
              height: _mainHeight,
              width: _mainWidth,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                mainAxisAlignment: controller.isBusy ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  controller.isBusy
                      ? CircularProgressIndicator()
                      : Container(
                          height: _mainHeight * 0.75,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var data = controller.eventsList![index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(RoutesConst.eventDetailsScreen, arguments: data.eventid);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: appColor4.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: _mainHeight * 0.075,
                                          width: _mainWidth * 0.16,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                            child: cachedImage(
                                                imageUrl: data.imageUrls != null && data.imageUrls!.isNotEmpty
                                                    ? data.imageUrls!.first.imageUrl
                                                    : ''),
                                          ),
                                        ),
                                        SizedBox(
                                          width: _mainWidth * 0.04,
                                        ),
                                        Container(
                                          width: screenWidth * 0.65,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.eventName != null
                                                    ? data.eventName!.replaceAll('_', ' ').capitalizeFirst!.toString()
                                                    : '',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: 3,
                                              ),
                                              SizedBox(
                                                height: _mainHeight * 0.005,
                                              ),
                                              Text('TO - ${data.receiverName}',
                                                  style: const TextStyle(
                                                      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
                                              SizedBox(
                                                height: _mainHeight * 0.005,
                                              ),
                                              Text(
                                                data.eventDescription ?? '',
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: controller.eventsList?.length ?? 0),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
