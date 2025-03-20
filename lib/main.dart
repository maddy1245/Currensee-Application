import 'package:eproject_currensee/bindings/general_binding.dart';
import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
import 'package:eproject_currensee/features/personalization/controllers/user_controller.dart';
import 'package:eproject_currensee/firebase_options.dart';
import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:eproject_currensee/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// 🔔 Local Notifications Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // 🛠️ Local Storage Initialize
  await GetStorage.init();

  // 🛠️ Splash Screen Preserve
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 🛠️ Firebase Initialization with Error Handling
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    Get.put(AuthenticationRepository());
  } catch (e) {
    debugPrint("🔥 Firebase Initialization Failed: $e");
  }

  // 🛠️ Supabase Initialization with Error Handling
  try {
    await Supabase.initialize(
      url: 'https://yudrkvbkkhrqikqijfjm.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...Xz2sxPYOkqP0HeuXTJdSk7TU28moDqeCUEgeIJUeJWs',
    );
  } catch (e) {
    debugPrint("🔥 Supabase Initialization Failed: $e");
  }

  // 🛠️ Local Notifications Initialize
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // 🛠️ Splash Screen Remove
  FlutterNativeSplash.remove();
  Get.put(UserController()); // ✅ Controller Initialize

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: Scaffold(
          backgroundColor: TColors.primary,
          body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}


