import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../controller/guest_dashboard_controller.dart';

class EventQrScannerScreen extends StatefulWidget {
  const EventQrScannerScreen({super.key});

  @override
  State<EventQrScannerScreen> createState() => _EventQrScannerScreenState();
}

class _EventQrScannerScreenState extends State<EventQrScannerScreen> {
  GuestDashboardController dashboardController = Get.find();
  bool isScanCompleted = false;
  List qrList = [];

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Qr Scanner', style: TextStyle(color: Colors.white, letterSpacing: 1, fontWeight: FontWeight.bold)),
        leading: getBackBarButton(),
      ),
      backgroundColor: Colors.black54,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Expanded(
              child: Container(
            // color: Colors.red,
            child: Column(children: [
              Text('Place the Qr in the area',
                  style: TextStyle(fontSize: 18, color: Colors.white, letterSpacing: 1, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('Scanning will be started automatically', style: TextStyle(fontSize: 16, color: Colors.white70)),
            ]),
          )),
          Expanded(
              flex: 4,
              child: MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.normal,
                  facing: CameraFacing.back,
                  //torchEnabled: true,
                ),
                onDetect: (capture) {
                  if (!isScanCompleted) {
                    // String code = capture.barcodes;
                    final List<Barcode> barcodes = capture.barcodes;
                    //final Uint8List? image = capture.image;
                    for (final barcode in barcodes) {
                      log('scanner details ${barcode.rawValue}');
                      debugPrint('Barcode found! ${barcode.rawValue}');
                      qrList.add(barcode.rawValue);
                    }

                    isScanCompleted = true;
                    var list = jsonDecode(qrList[0]);
                    if (list[0].toString().contains('heh')) {
                      if (list[1].toString() == (dashboardController.mobileNo)) {
                        Get.offAllNamed(RoutesConst.guestCoverScreen,
                            arguments: list[2].toString(), parameters: {'type': 'For You'});
                      } else {
                        AppWidgets.getToast(message: ' This qr Event is not valid for you', color: primaryColor);
                        Get.back();
                      }
                    } else {
                      AppWidgets.getToast(message: ' This qr is not valid for Heart-e-Homies ', color: primaryColor);
                      Get.back();
                    }
                  }
                },
              )),
          Expanded(
              child: Container(
            //color: Colors.amber,
            child: const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('Powered by Heart-e-Homies', style: TextStyle(fontSize: 18, color: Colors.white70)),
              ],
            ),
          ))
        ]),
      ),
    );
  }

  Widget getBackBarButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: screenHeight * 0.025, bottom: screenHeight * 0.005),
          child: CircleAvatar(
            child: Icon(
              Icons.arrow_back,
              color: Colors.red.shade900,
            ),
            backgroundColor: Colors.grey.shade200,
          )),
    );
  }
}
