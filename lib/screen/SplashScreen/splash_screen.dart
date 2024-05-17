import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reclamationapp/providers/themes_provider.dart';
import 'package:reclamationapp/screen/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  //Route
  static const String routeName = "/";

  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  //Actions : Timer launch
  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

  //Nav
  void navigationPage() async {
    await SharedPreferences.getInstance().then((sp) {
      sp.clear();
      if (sp.containsKey("currentUser")) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          //
        });
      });
    controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //BUILD
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        backgroundColor: themeProvider.currentTheme.scaffoldBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                themeProvider.toggleTheme();
              },
              child: const Text("data"),
            ),
            Image.asset(
              "assets/images/logo.png",
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),

            //charging progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: LinearProgressIndicator(
                value: controller.value,
                // color: ,
              ),
            ),
          ],
        ));
  }
}
