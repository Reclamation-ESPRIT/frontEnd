import 'package:flutter/material.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/screen/auth/web/login_web_screen.dart';
import 'package:reclamationapp/screen/auth/mobile/login_mobile.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Container(
              width: constraints.maxWidth,
              decoration: const BoxDecoration(
                color: AppTheme.lightBackground,
              ),
              child: constraints.maxWidth < 500
                  ? const LoginMobileScreen(
                      iconPath: "assets/images/reclamationLogo.png",
                    )
                  : const LoginWebScreen(
                      iconPath: "assets/images/reclamationLogo.png"),
            ),
          );
        },
      ),
    );
  }
}
