import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/show_event_module/model/events_list_model.dart';
import 'package:where_hearts_meet/show_event_module/service/show_event_service.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';

import '../../create_event_module/model/add_event_model.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/services/firebase_firestore_controller.dart';
import '../../utils/services/firebase_storage_controller.dart';

class EventListController extends BaseController {
  List<EventsListModel>? eventsList;

  final showEventService = ShowEventApiService();

  @override
  void onInit() {
    getEventList();
    super.onInit();
  }

  Future<void> getEventList() async {
    setBusy(true);
    eventsList = await showEventService.getAllEvents();
    setBusy(false);
    // eventsList = [EventsListModel(
    //   imageUrls: [
    //    ImageUrls(
    //      imageUrl: "https://www.southernliving.com/thmb/1VFCIwa-50xPATCZHcSKdlYc1BY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/SL-Birthday_Quote_1-da9fac5d17bd4582add4fd7e15376127.png",
    //      imageId: '12345'
    //    ),
    //     ImageUrls(
    //         imageUrl: "https://parade.com/.image/t_share/MjAzMzU3NzQxMzU4NTIzOTgz/happy-birthday-wishes-messages.jpg",
    //         imageId: '123456'
    //     ),
    //   ]
    // )];
    update();
  }
}
