import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heart_e_homies/guest_view/service/guest_view_service.dart';
import 'package:heart_e_homies/utils/consts/color_const.dart';
import 'package:heart_e_homies/utils/controller/base_controller.dart';
import 'package:heart_e_homies/utils/dialogs/pop_up_dialogs.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../routes/routes_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';

class GuestViewController extends BaseController {
  final _apiService = GuestViewService();

  String mobileNo = '';
  final textController = TextEditingController();
  final scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
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
    textController.text = 'MTJfSGFwcHkgaGFwcHkgYmlydGhkYXk=';
    showLoaderDialog(context: Get.context!);
    final response = await _apiService.getEventDetails(eventId: textController.text, mobileNo: mobileNo);
    cancelDialog();
    if (response != null) {
      final repo = locator<CreatedEventRepo>();
      repo.setEvent(response);
      repo.setEventCreated(EventsCreated.forUser);
      repo.setUserType(UserType.guest);
      Get.toNamed(RoutesConst.eventCoverScreen);
    } else {
      AppWidgets.getToast(message: 'Event code is wrong! ', color: errorColor);
    }
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
        final response =
            await _apiService.getEventDetails(eventId: list[2].toString(), mobileNo: mobileNo);
        if (response != null) {
          final repo = locator<CreatedEventRepo>();
          repo.setEvent(response);
          repo.setEventCreated(EventsCreated.forUser);
          repo.setUserType(UserType.guest);
          Get.toNamed(RoutesConst.eventCoverScreen);
        } else {
          AppWidgets.getToast(message: 'Event code is wrong! ', color: errorColor);
        }
      } else {
        AppWidgets.getErrorSnackbar(
          ' This qr Event is not valid for you',
        );
      }
    } else {
      AppWidgets.getToast(message: ' This qr is not valid for Heart-e-Homies ', color: errorColor);
    }
  }

  @override
  void onClose() {
    scannerController.dispose();
    textController.dispose();
    super.onClose();
  }
}
