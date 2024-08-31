import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';

import 'app_bar_widget.dart';

class CustomPhotoView extends StatelessWidget {
  final String? imageUrl;

  const CustomPhotoView({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: appBarWidget(title: '', backgroundColor: Colors.black),
        body: imageUrl != null && imageUrl!.isNotEmpty
            ? PhotoView(
                imageProvider: NetworkImage(imageUrl!),
                maxScale: 4.0,
                minScale: 0.1,
              )
            : PhotoView(
                imageProvider: const AssetImage(dummyImage),
                maxScale: 1.0,
                minScale: 1.0,
              ));
  }
}
