import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/profile_module/model/people_model.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/model/event_info_model.dart';

import '../model/user_info_model.dart';

class MiniUserCard extends StatelessWidget {
  final PeopleModel peopleModel;
  final Function onCardTap;
  final Color eventColor;
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  MiniUserCard({Key? key, required this.peopleModel, required this.onCardTap, required this.eventColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 7, top: 0, bottom: 7, right: 0),
      width: _mainWidth * 0.7,
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
                  width: _mainWidth * 0.39,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child:peopleModel.imageUrl != null && peopleModel.imageUrl != '' ? Image.network(
                        peopleModel.imageUrl ?? '',
                        fit: BoxFit.fill,
                      ):Icon(Icons.person))),
              Text(peopleModel.name ?? '')
            ],
          )),
    );
  }
}
