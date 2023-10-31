import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:where_hearts_meet/splash_module/screens/splash_screen.dart';
import 'package:where_hearts_meet/utils/routes/app_routes.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';
import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';
import 'package:where_hearts_meet/utils/services/firebase_storage_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  setUp();

}

void setUp(){
  Get.put(FirebaseAuthController());
  Get.put(FirebaseFireStoreController());
  Get.put(FirebaseStorageController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: AppRoutes.getRoutes(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(),
    );
  }
}
