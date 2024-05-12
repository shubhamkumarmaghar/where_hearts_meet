import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/model/event_info_model.dart';

import '../../create_event_module/model/add_event_model.dart';

class EventCard extends StatelessWidget {
  final AddEventModel eventInfoModel;
  final Function onCardTap;
  final Color eventColor;
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  EventCard({Key? key, required this.eventInfoModel, required this.onCardTap,required this.eventColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onCardTap();
      },
      child: Container(
        width: _mainWidth*0.85,
        padding: const EdgeInsets.only(left: 7, top: 0, bottom: 7, right: 0),
        decoration: BoxDecoration(
            color: eventColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
        child: Container(
            padding: const EdgeInsets.only(left: 7, top: 7, right: 7),
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              children: [
                SizedBox(
                    height: _mainHeight * 0.2,
                    width: _mainWidth * 0.75,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.network(
                          eventInfoModel.imageUrl ?? '',
                          fit: BoxFit.fill,
                        ))),
                SizedBox(
                  height: _mainHeight*0.01,
                ),
                Text(eventInfoModel.eventName ??'')
              ],
            )),
      ),
    );
  }
}
