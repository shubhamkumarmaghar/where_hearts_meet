import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';

import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/screen_const.dart';
import '../consts/string_consts.dart';
import '../model/dropdown_model.dart';

void showThemeDialog() {
  Get.changeThemeMode(ThemeMode.light);
}

void showSnackBar({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message ?? 'Something went wrong!'),
  ));
}

void showLoaderDialog({required BuildContext context, String? loadingText, Color? color}) {
  showAdaptiveDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const SizedBox(
        height: 50,
        width: 50,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(whiteColor), backgroundColor: primaryColor),
            ),
          ),
        ),
      );
    },
  );
}

void showCupertinoActionSheetOptions(
    {required String button1Text,
    required String button2Text,
    required Function onTapButton1,
    required Function onTapButton2}) {
  showCupertinoModalPopup(
    context: Get.context!,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            Get.back();
            onTapButton1();
          },
          child: Text(
            button1Text,
            style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Get.back();
            onTapButton2();
          },
          child: Text(
            button2Text,
            style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Get.back();
        },
        isDefaultAction: true,
        child: const Text(
          StringConsts.cancel,
          style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    ),
  );
}

void cancelDialog() => Get.back();

void showAlertDialogWithOK({String? message, required BuildContext context, Function? onCLick}) {
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Text(
      message ?? 'Are you sure?',
      style: const TextStyle(fontSize: 16),
    ),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: false,
        child: const Text('Ok', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () {
          onCLick != null ? onCLick() : cancelDialog();
        },
      ),
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showAlertDialogWithYesNo({String? message, required BuildContext context, required Function onYes}) {
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Text(
      message ?? 'Are you sure?',
      style: const TextStyle(fontSize: 16),
    ),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: false,
        child: const Text('Yes', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () {
          onYes();
        },
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('No', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () {
          cancelDialog();
        },
      ),
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showLogoutAlertDialog({String? message, required BuildContext context, required Function logOutFunction}) {
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Center(
        child: Text(message ?? 'Are you sure to exit?',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: false,
        child: const Text('Yes', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () async {
          await logOutFunction();
        },
      ),
      CupertinoDialogAction(
        isDefaultAction: false,
        child: const Text('No', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () {
          cancelDialog();
        },
      ),
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<DropDownModel?> showButtonDialog(
    {required BuildContext context, required List<DropDownModel> dataList, double? height, double? width}) async {
  return await showDialog<DropDownModel>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Container(
              height: height ?? screenHeight * 0.45,
              width: width ?? screenWidth * 0.8,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              child: ListView.separated(
                itemCount: dataList.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: screenHeight * 0.02,
                ),
                itemBuilder: (BuildContext context, int index) {
                  var data = dataList[index];
                  return InkWell(
                    onTap: () {
                      Get.back(result: data);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.03,
                      ),
                      decoration: BoxDecoration(color: appColor1, borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          data.icon ?? const SizedBox.shrink(),
                          Text(
                            data.title,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    },
  );
}

Future<Color?> showColorPickerDialog({required BuildContext context, required Color selectedColor}) {
  Color currentColor = selectedColor;
  return showDialog<Color>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (value) {
              currentColor = value;
            },
          ),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   showLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
          //
          // child: MultipleChoiceBlockPicker(
          //   pickerColors: currentColors,
          //   onColorsChanged: changeColors,
          // ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Select'),
            onPressed: () {
              Get.back(result: currentColor);
            },
          ),
        ],
      );
    },
  );
}

Future<AppActions?> showMessageActionDialog(BuildContext context) {
  return showCupertinoDialog<AppActions>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text(
          'Choose an Option',
        ),
        actions: [
          CupertinoDialogAction(
            textStyle: textStyleAbel(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w600),
            onPressed: () {
              Get.back(result: AppActions.edit);
            },
            child: const Text('Edit'),
          ),
          CupertinoDialogAction(
            textStyle: textStyleAbel(fontSize: 16, color: errorColor, fontWeight: FontWeight.w600),
            onPressed: () {
              Get.back(result: AppActions.delete);
            },
            isDestructiveAction: true,
            child: const Text(
              'Delete',
            ),
          ),
          CupertinoDialogAction(
            textStyle: textStyleAbel(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
            ),
          ),
        ],
      );
    },
  );
}
