import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/widgets/image_dialog.dart';
import '../controller/profile_setup_controller.dart';

class AddProfilePicturePage extends StatelessWidget {
  final ProfileSetupController controller;
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  AddProfilePicturePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: _mainHeight*0.12
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              'Profile Picture',style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,

            ),
            ),
          ),
          SizedBox(
            height: _mainHeight * 0.2,
          ),
          Container(
            alignment: Alignment.center,
            height: _mainHeight * 0.15,
            child: NeumorphicButton(
              onPressed: () async {
                await Get.dialog(ImageDialog(onGalleryClicked: () {}, onCameraClicked: () {}));
              },
              style: NeumorphicStyle(
                color: greyColor.withOpacity(0.1),
                depth: -5,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
              ),
              child: Icon(
                Icons.upload_rounded,
                size: _mainHeight * 0.12,
                color: blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
