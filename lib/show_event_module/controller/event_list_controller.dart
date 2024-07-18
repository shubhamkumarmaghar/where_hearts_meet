import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/show_event_module/model/events_list_model.dart';
import 'package:where_hearts_meet/show_event_module/service/show_event_service.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

class EventListController extends BaseController {
  List<EventsListModel>? eventsList=[];

  final showEventService = ShowEventApiService();

  @override
  void onInit() {
    getEventList();
    super.onInit();
  }

  Future<void> getEventList() async {
    setBusy(true);
    eventsList = await showEventService.getAllEvents();
    final storage = GetStorage();
    log('kkkk ${storage.read(userMobile)}--${storage.read(userId)}--${storage.read(username)}--${storage.read(userMobile)}--${storage.read(profileUrl)}--${storage.read(firstName)}');

    setBusy(false);
    update();
  }
  Future<void> getEventListCreatedForMe() async {
    setBusy(true);
    await showEventService.getAllEventsCreatedForMe();
    setBusy(false);
    update();
  }
}
