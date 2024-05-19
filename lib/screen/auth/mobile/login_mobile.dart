import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reclamationapp/Services/auth.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/customWidgets/default_alert_dialog.dart';
import 'package:reclamationapp/screen/reclamation/mobile/reclamation_add.dart';

class LoginMobileScreen extends StatelessWidget {
  final String? iconPath;
  const LoginMobileScreen({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                fit: BoxFit.cover,
                width: constraints.maxWidth * 0.4,
                height: constraints.maxHeight * 0.25,
                "assets/icons/design.png",
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                fit: BoxFit.fill,
                width: constraints.maxWidth * 0.5,
                height: constraints.maxHeight * 0.2,
                "assets/icons/design.png",
              ),
            ),
            Positioned(
              top: constraints.maxHeight * 0.3,
              child: SizedBox(
                width: constraints.maxWidth * 0.6,
                child: Image.asset(
                  iconPath!,
                  fit: BoxFit.fill,
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .shimmer(
                      delay: 3000.ms,
                    ),
              ),
            ),
            Positioned(
              top: constraints.maxHeight * 0.65,
              child: OutlinedButton(
                onPressed: () async {
                  UserServices userServices = UserServices();

                  final connectedUser = await userServices.loginGoogle();
                  if (!context.mounted) return;

                  if (connectedUser.email != null &&
                      connectedUser.email!.contains("@esprit.tn")) {
                    Navigator.pushReplacementNamed(
                        context, AddReclamationScreen.routeName,
                        arguments: connectedUser); //todo change the argument
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => DefaultAlertDialog.info(
                          "Sign in error",
                          "you should connect with your esprit account"),
                    );
                  }
                },
                child: SizedBox(
                  width: constraints.maxWidth * 0.45,
                  height: constraints.maxHeight * 0.07,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png",
                              width: constraints.maxWidth * 0.07)
                          .animate(autoPlay: true)
                          .shimmer(),
                      SizedBox(width: constraints.maxWidth * 0.05),
                      const FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Google Sign In",
                          style: TextStyle(
                            color: AppTheme.lightPrimary,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
