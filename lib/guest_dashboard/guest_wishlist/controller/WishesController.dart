import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../create_event/model/wishes_model.dart';
import '../../../utils/controller/base_controller.dart';
import '../../guest_home/controller/guest_home_controller.dart';
import '../../guest_home/service/guest_receive_event.dart';

class GuestWishesController extends BaseController {
  final homeController = Get.find<GuestHomeController>();
  List<WishesModel> guestWishesModel = [];

  GuestReceiveService guestReceiveService = GuestReceiveService();
  String eventId='';


  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments as String;
    eventId = arg;
    getData(args: eventId);
    }
  Future<void> getData({String? args, Map? data}) async {
    getEventWishes(args??"");
    update();
  }
  Future<void> getEventWishes(String eventId) async {
    // setBusy(true);
    var res = await guestReceiveService.getWishesList(eventId: eventId);
    guestWishesModel = res;
    log('Data ${guestWishesModel.length}');
    // setBusy(false);
    update();
  }
}