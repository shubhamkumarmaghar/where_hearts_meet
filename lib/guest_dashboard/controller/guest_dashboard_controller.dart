import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/routes_const.dart';
import '../../show_event_module/model/event_details_model.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/controller/base_controller.dart';
import '../guest_home/service/guest_receive_event.dart';

class GuestDashboardController extends BaseController {
  EventDetailsModel? eventDetails;
  String mobileNo = '';
  GuestReceiveService guestReceiveService = GuestReceiveService();
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    mobileNo = GetStorage().read(userMobile);


  }



  Future<void> getEventDetails({required String eventId ,bool byYou = false}) async {
    setBusy(true);
    eventDetails = await guestReceiveService.getEventDetails(eventId: eventId, mobileNo: mobileNo,type: byYou);
    setBusy(false);
    update();
    Get.offAllNamed(RoutesConst.guestCoverScreen,
        arguments: eventDetails?.eventid,
        parameters: {'type':  'For You'}
    );
  }

}