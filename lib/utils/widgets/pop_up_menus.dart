import 'dart:developer';

import 'package:flutter/material.dart';
import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/screen_const.dart';

Widget moreViewPopUpMenu({Function? onDelete, Function? onView, bool showBackground = true, Function? onShare}) {
  return showBackground
      ? Container(
          height: screenHeight * 0.04,
          width: screenHeight * 0.04,
          decoration: BoxDecoration(color: primaryColor.withOpacity(0.5), shape: BoxShape.circle),
          child: PopupMenuButton<AppActions>(
            color: Colors.white,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
              size: 20,
            ),
            onSelected: (AppActions result) {
              log(result.name);
              if (result == AppActions.delete) {
                onDelete != null ? onDelete() : () {};
              } else if (result == AppActions.view) {
                onView != null ? onView() : () {};
              } else if (result == AppActions.share) {
                onShare != null ? onShare() : () {};
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<AppActions>>[
              const PopupMenuItem<AppActions>(
                value: AppActions.delete,
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: errorColor,
                  ),
                  title: Text(
                    'Delete',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              if (onView != null)
                const PopupMenuItem<AppActions>(
                  value: AppActions.view,
                  child: ListTile(
                    leading: Icon(
                      Icons.remove_red_eye_rounded,
                      color: primaryColor,
                    ),
                    title: Text(
                      'View',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              if (onShare != null)
                const PopupMenuItem<AppActions>(
                  value: AppActions.share,
                  child: ListTile(
                    leading: Icon(
                      Icons.share,
                      color: primaryColor,
                    ),
                    title: Text(
                      'Share',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
            ],
          ),
        )
      : PopupMenuButton<AppActions>(
          color: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          icon: const Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
            size: 30,
          ),
          onSelected: (AppActions result) {
            if (result == AppActions.delete) {
              onDelete != null ? onDelete() : () {};
            } else if (result == AppActions.view) {
              onView != null ? onView() : () {};
            } else if (result == AppActions.share) {
              onShare != null ? onShare() : () {};
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<AppActions>>[
            const PopupMenuItem<AppActions>(
              value: AppActions.delete,
              child: ListTile(
                leading: Icon(
                  Icons.delete,
                  color: errorColor,
                ),
                title: Text(
                  'Delete',
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            if (onView != null)
              const PopupMenuItem<AppActions>(
                value: AppActions.view,
                child: ListTile(
                  leading: Icon(
                    Icons.remove_red_eye_rounded,
                    color: primaryColor,
                  ),
                  title: Text(
                    'View',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            if (onShare != null)
              const PopupMenuItem<AppActions>(
                value: AppActions.share,
                child: ListTile(
                  leading: Icon(
                    Icons.share,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Share',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        );
}

Widget deleteProfileView({required Function onDelete}) {
  return PopupMenuButton<AppActions>(
    color: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
    icon: const Icon(
      Icons.more_vert_rounded,
      color: Colors.white,
      size: 30,
    ),
    onSelected: (AppActions result) {
      if (result == AppActions.delete) {
        onDelete();
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<AppActions>>[
      const PopupMenuItem<AppActions>(
        value: AppActions.delete,
        child: ListTile(
          leading: Icon(
            Icons.delete,
            color: errorColor,
          ),
          title: Text(
            'Delete',
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ],
  );
}
