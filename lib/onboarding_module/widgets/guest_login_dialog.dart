import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';

void showGuestLoginDialog({required String message,required Function callBack,required BuildContext context}){
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Center(child: Text(message ?? 'Are you sure to exit?', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400))),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: false,
        child: const Text('Yes', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () async {
          await callBack();
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
