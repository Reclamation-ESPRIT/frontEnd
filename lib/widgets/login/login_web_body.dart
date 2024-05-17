// login_web_body.dart
import 'package:flutter/material.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/widgets/login/login_form.dart';

class LoginWebBody extends StatelessWidget {
  const LoginWebBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              welcomeText(context),
              SizedBox(height: constraints.maxHeight * 0.1),
              LoginForm(
                constraints: constraints,
              ),
            ],
          ),
        );
      },
    );
  }
}

// welcome_text.dart
Widget welcomeText(BuildContext context) {
  return const Text(
    "Welcome Back to ESPRIT Reclamation",
    style: TextStyle(
      color: AppTheme.lightPrimary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
