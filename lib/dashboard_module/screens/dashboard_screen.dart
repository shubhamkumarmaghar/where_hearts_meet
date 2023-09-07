import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_drawer_screen.dart';

class DashboardScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [Container(margin: EdgeInsets.only(right: _mainWidth * 0.04), child: const Icon(Icons.notifications))],
      ),
      drawer: DashboardDrawerScreen(),
      body: Container(
      ),
    );
  }
}
