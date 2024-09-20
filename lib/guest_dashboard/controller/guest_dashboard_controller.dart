import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../routes/routes_const.dart';
import '../../show_event_module/model/event_details_model.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../guest_home/service/guest_receive_event.dart';

class GuestDashboardController extends BaseController {
  EventDetailsModel? eventDetails;
  String mobileNo = '';
  GuestReceiveService guestReceiveService = GuestReceiveService();
  final TextEditingController textController = TextEditingController();
  final MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );

  @override
  void onInit() {
    super.onInit();
    mobileNo = GetStorage().read(userMobile) ?? '';
  }

  Future<void> submitEventCode() async {
    if (textController.text.length < 5) {
      AppWidgets.getToast(message: 'Please enter valid Event Code');
      return;
    }
    Get.offAllNamed(RoutesConst.guestCoverScreen, arguments: textController.text, parameters: {'type': 'For You'});
  }

  Future<void> onQRDetected(capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    List<String> qrList = [];
    for (final barcode in barcodes) {
      qrList.add(barcode.rawValue ?? '');
    }
    var list = jsonDecode(qrList[0]);
    if (list[0].toString().contains('heh')) {
      if (list[1].toString() == mobileNo) {
        Get.offAllNamed(RoutesConst.guestCoverScreen, arguments: list[2].toString(), parameters: {'type': 'For You'});
      } else {
        AppWidgets.getToast(message: ' This qr Event is not valid for you', color: primaryColor);
      }
    } else {
      AppWidgets.getToast(message: ' This qr is not valid for Heart-e-Homies ', color: primaryColor);
    }
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
