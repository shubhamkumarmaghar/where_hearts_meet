import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/routes/app_routes.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import 'package:where_hearts_meet/splash_module/screens/splash_screen.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/service_const.dart';
import 'package:where_hearts_meet/utils/repository/created_event_repo.dart';

import 'package:where_hearts_meet/utils/services/dio_injector.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';
import 'package:where_hearts_meet/utils/services/firebase_storage_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await GetStorage.init();
  if (kIsWeb) {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDVQiOZ2uSbDTF8UzZXNEtsCBW-Ro25gt0",
            authDomain: "where-hearts-meet.firebaseapp.com",
            projectId: "where-hearts-meet",
            storageBucket: "where-hearts-meet.appspot.com",
            messagingSenderId: "996974929233",
            appId: "1:996974929233:web:079825a07c1530872d1f70",
            measurementId: "G-Q89KKB6P6B"),
      );
    } catch (e) {
      log('Error initializing Firebase: $e');
    }
  } else {
    await Firebase.initializeApp();
  }

  await setUp();
  runApp(const MyApp());
}

Future<void> setUp() async {
  Get.put(FirebaseAuthController());
  Get.put(FirebaseStorageController());
  locator.registerSingleton<DioInjector>(DioInjector());
  locator.registerSingleton<CreatedEventRepo>(CreatedEventRepo());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Heart-e-homies',
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(0.9)), child: child ?? Text(''));
      },
      getPages: AppRoutes.getRoutes(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      color: primaryColor,
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        primarySwatch: getMaterialColor(primaryColor),
      ),
      home: const SplashScreen(),
      //initialRoute: RoutesConst.createGiftsScreen,
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
