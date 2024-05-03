import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:where_hearts_meet/splash_module/screens/splash_screen.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/routes/app_routes.dart';
import 'package:where_hearts_meet/utils/services/dio_injector.dart';
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
  Get.lazyPut(() => DioInjector());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: AppRoutes.getRoutes(),
      themeMode: ThemeMode.system,
      color: primaryColor,
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        primarySwatch: getMaterialColor(primaryColor),
      ),
      home: SplashScreen(),
    );
  }
  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;
    final int alpha = color.alpha;

    final Map<int, Color> shades = {
      50: Color.fromARGB(alpha, red, green, blue),
      100: Color.fromARGB(alpha, red, green, blue),
      200: Color.fromARGB(alpha, red, green, blue),
      300: Color.fromARGB(alpha, red, green, blue),
      400: Color.fromARGB(alpha, red, green, blue),
      500: Color.fromARGB(alpha, red, green, blue),
      600: Color.fromARGB(alpha, red, green, blue),
      700: Color.fromARGB(alpha, red, green, blue),
      800: Color.fromARGB(alpha, red, green, blue),
      900: Color.fromARGB(alpha, red, green, blue),
    };

    return MaterialColor(color.value, shades);
  }
}
