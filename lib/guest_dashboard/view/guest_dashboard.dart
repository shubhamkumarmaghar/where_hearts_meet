import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/utils/util_functions/decoration_functions.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/widgets/designer_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../../utils/widgets/or_widget.dart';
import '../controller/guest_dashboard_controller.dart';

class GuestDashboard extends StatelessWidget {
  const GuestDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuestDashboardController>(
        init: GuestDashboardController(),
        builder: (controller) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              titleSpacing: 20,
              title: Text(
                'Guest  User ( ${controller.mobileNo} )',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
              actions: [
                GestureDetector(
                  onTap: () async=>await logoutFunction(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: errorColor, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                SizedBox(
                  height: screenHeight * 0.7,
                  child: MobileScanner(
                    controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.normal,
                      facing: CameraFacing.back,
                    ),
                    onDetect: controller.onQRDetected,
                    onScannerStarted: (scanner) {
                      debugPrint('onScannerStarted $scanner');
                    },
                    placeholderBuilder: (context, child) {
                      return Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05000000074505806),
                        ),
                      );
                    },
                    overlay: QRScannerOverlay(
                      overlayColor: Colors.black.withOpacity(0.5),
                      scanAreaSize: const Size(250, 250),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: screenWidth,
                            margin: const EdgeInsets.only(top: 32.5),
                            padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0, bottom: 30.0),
                            decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Scan Event QR',
                                  textAlign: TextAlign.center,
                                  style: textStyleMontserrat(
                                      color: darkGreyColor, fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Hold your camera and scan to view Event',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: lightGreyColor),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const ORWidget(),
                                const SizedBox(
                                  height: 25,
                                ),
                                DesignerTextField(
                                  onChanged: (text) {},
                                  hint: 'Enter Event Code',
                                  controller: controller.textController,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                GradientButton(
                                  height: 55,
                                  width: screenWidth * 0.88,
                                  title: 'Submit Code',
                                  onPressed: controller.submitEventCode,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 65,
                              height: 65,
                              decoration: const ShapeDecoration(
                                color: primaryColor,
                                shape: OvalBorder(),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
