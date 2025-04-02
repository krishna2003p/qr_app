import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/screens/home/home_provider.dart';
import 'package:myfirstapp/screens/provider/auto_provider.dart';
import 'package:myfirstapp/splash/splash_screen.dart';
import 'package:myfirstapp/util/SharedPrefrence%20Helper/shared_prefs_helper.dart';
import 'package:provider/provider.dart';

import 'Custom Designs/Custom_App_Bar/bottom_nav_provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}




