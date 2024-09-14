
import 'dart:io';
import 'package:flutter/material.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/widgets/base_container.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseContainer(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.07,
              ),
              SizedBox(
                height: screenHeight * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
