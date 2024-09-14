import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/profile_setup_controller.dart';

class AddLocationPage extends StatelessWidget {
  final ProfileSetupController controller;
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  AddLocationPage({Key? key,required this.controller}) : super(key: key);

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
              'Location',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,

            ),
            ),
          ),
          SizedBox(
            height: _mainHeight * 0.2,
          ),
          Container(
            height: _mainHeight*0.1,
              width: _mainHeight*0.1,
              decoration: BoxDecoration(
                border: Border.all(color: blackColor,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(100),)
              ),
              child: Icon(Icons.location_on,size: 50,color: blackColor,)),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _mainWidth*0.1),
            child: GradientButton(
              title: 'Allow Location',
              enabled: true,
            buttonColor: blackColor,
              height: _mainHeight * 0.06,
              width: _mainWidth ,
              onPressed: () {
                controller.completeSignUp();
              },
            ),
          )
        ],
      ),
    );
  }
}
