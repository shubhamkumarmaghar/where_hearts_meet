import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';

Widget cachedImage({String? imageUrl, double height = 90, double width = 120,BoxFit? boxFit}) {
  return imageUrl != null && imageUrl.isNotEmpty
      ? CachedNetworkImage(
          memCacheHeight: height.toInt(),
          memCacheWidth: width.toInt(),
          height: height,
          width: width,
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit:boxFit?? BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            period: const Duration(milliseconds: 1500),
            child: Container(
              height: height,
              width: width,
              color: primaryColor,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(errorImage), fit: BoxFit.cover),
            ),
          ),
        )
      : Container(
          decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(dummyImage), fit: BoxFit.cover),
        ));
}
