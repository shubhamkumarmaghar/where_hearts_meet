import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/widgets/custom_text_field.dart';
import '../controller/guest_login_controller.dart';

class GuestLogin extends StatefulWidget {
  const GuestLogin({super.key});

  @override
  State<GuestLogin> createState() => _GuestLoginState();
}

class _GuestLoginState extends State<GuestLogin> {
  final controller = Get.find<GuestLoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      color: Colors.white,
      child: Column(children: [
        CustomTextField(
            title: 'Mobile Number',
            error: controller.errorPhoneNumberText.value,
            inputType: TextInputType.phone,
            hint: 'Please enter mobile number',
            onChanged: controller.onPhoneNumberChanged,
            controller: controller.phoneNumberController),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            controller.verifyPhoneNumber();
          },
          child: Text("Verify Phone Number"),
        ),
      ]),

    ));
  }
}
