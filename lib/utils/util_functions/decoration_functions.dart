import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_image_generator/qr_image_generator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../create_event/model/event_response_model.dart';
import '../../routes/routes_const.dart';
import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/images_const.dart';
import '../dialogs/pop_up_dialogs.dart';
import '../widgets/cached_image.dart';
import '../widgets/util_widgets/app_widgets.dart';

Color getColorBasedOnIndex(int index) {
  int temp = index % 6;
  if (index >= 6) {
    temp = index % 6;
  } else {
    temp = index;
  }
  switch (temp) {
    case 0:
      return const Color(0XFF0089C6);
    case 1:
      return const Color(0XFF80A93F);
    case 2:
      return const Color(0XFFDF7927);
    case 3:
      return const Color(0XFFDF317A);
    case 4:
      return const Color(0XFF24B856);
    case 5:
      return const Color(0XFFFCAE1A);
    default:
      return Colors.purple;
  }
}

LinearGradient get backgroundGradient {
  return const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
    primaryColor,
    appColor1,
    appColor2,
    appColor3,
  ]);
}

Widget get appHeader {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: screenHeight * 0.08,
        child: Image.asset(
          logo,
        ),
      ),
      SizedBox(
        width: screenWidth * 0.01,
      ),
      Text(
        'Heart-e-homies',
        style: GoogleFonts.aclonica(
            decoration: TextDecoration.none, color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
      ),
    ],
  );
}

Widget eventHeaderView({required String text, String? image}) {
  return ClayContainer(
    color: primaryColor,
    borderRadius: 30,
    child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Container(
                height: 40,
                width:40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: ClipRRect(borderRadius: BorderRadius.circular(50), child: cachedImage(imageUrl: image))),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            SizedBox(
              width: screenWidth * 0.65,
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
          ],
        )),
  );
}

Widget createEventHeader({required String title, String? image}) {
  return Row(
    children: [
      Container(
        height: screenHeight * 0.05,
        width: screenHeight * 0.05,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
        child: ClipRRect(borderRadius: BorderRadius.circular(100), child: cachedImage(imageUrl: image)),
      ),
      SizedBox(
        width: screenWidth * 0.03,
      ),
      SizedBox(
        width: screenWidth * 0.7,
        child: Text(
          title,
          style: GoogleFonts.aclonica(
              decoration: TextDecoration.none, color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
    ],
  );
}

String getYearTime(String? date) {
  String formattedDate = '';
  if (date != null && date.isNotEmpty) {
    try {
      final dateTime = DateTime.parse(date);
      formattedDate = '${dateTime.year}-${addZero(dateTime.month)}-${addZero(dateTime.day)}';
    } catch (e) {
      log(e.toString());
    }
  }

  return formattedDate;
}

Future<void> logoutFunction() async {
  showLoaderDialog(context: Get.context!);
  await GetStorage().erase();
  await FirebaseAuth.instance.signOut();
  cancelDialog();
  Get.offAllNamed(RoutesConst.loginScreen);
}

String addZero(int value) {
  return value > 9 ? value.toString() : '0$value';
}

TextStyle textStyleMontserrat(
    {double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration}) {
  return GoogleFonts.montserrat(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);
}

TextStyle textStyleDangrek({double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration}) {
  return GoogleFonts.dangrek(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);
}

TextStyle textStyleAleo({double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration}) {
  return GoogleFonts.aleo(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);
}

TextStyle textStyleAclonica({double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration}) {
  return GoogleFonts.aclonica(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);
}

TextStyle textStyleBasic({double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration}) {
  return GoogleFonts.basic(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);

}
TextStyle textStyleAbhayaLibre({double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration}) {
  return GoogleFonts.abhayaLibre(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);
}

TextStyle textStyleDancingScript(
    {double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration,double? height}) {
  return GoogleFonts.dancingScript(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      height: height,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);
}

TextStyle textStyleMoonDance({double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration}) {
  return GoogleFonts.moonDance(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);
}

TextStyle textStyleAbel({double? fontSize, Color? color, FontWeight? fontWeight, TextDecoration? textDecoration}) {
  return GoogleFonts.abel(
      color: color ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 22,
      decoration: textDecoration,
      decorationColor: color ?? Colors.white);
}

Future<File?> cropImage({required String filePath, bool? isProfileImage}) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    cropStyle: isProfileImage != null && isProfileImage ? CropStyle.circle : CropStyle.rectangle,
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),
      IOSUiSettings(
        title: 'Cropper',
        minimumAspectRatio: 1.0,
        aspectRatioLockEnabled: true,
      ),
    ],
  );

  if (croppedImage != null) {
    return File(croppedImage.path);
  }

  return null;
}

Future<String?> generateThumbnail(String videoUrl) async {
  final temp = await getTemporaryDirectory();
  String? fileName;
  try {
    fileName = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: temp.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: (screenHeight * 0.6).toInt(),
        quality: 75,
        timeMs: 1);
  } catch (e) {
    log(e.toString());
  }
  return fileName;
}

Future<void> shareEvent({required EventResponseModel eventModel, required BuildContext context}) async {
  showLoaderDialog(context: context);
  final file = await _generateQRImage(model: eventModel);
  cancelDialog();
  if (file != null) {
    XFile qrImage = XFile(file.path);
    final result = await Share.shareXFiles([qrImage],
        text: 'Event - ${eventModel.eventName} , Event Code - ${eventModel.eventid}');
    if (result.status == ShareResultStatus.success) {
      AppWidgets.getToast(message: 'Event code shared successfully');
    } else {
      AppWidgets.getToast(message: 'Something went wrong');
    }
  }
}

Future<File?> _generateQRImage({required EventResponseModel model}) async {
  final dir = await getApplicationDocumentsDirectory();
  final qrFile = File('${dir.path}/${model.eventid}.png');
  if (await qrFile.exists()) {
    return qrFile;
  } else {
    final generator = QRGenerator();
    File? file;
    try {
      final res = await generator.generate(
        data: jsonEncode(['heh', model.receiverPhoneNumber, model.eventid]),
        filePath: '${dir.path}/${model.eventid}.png',
      );
      file = File(res);
      return file;
    } catch (e) {
      log(e.toString());
    }
    return file;
  }
}

Color convertIntToColor(String? color) {
  if (color == null || color.isEmpty) {
    return Colors.black;
  }
  final colorAsInt = int.parse(color);
  return Color(colorAsInt);
}
