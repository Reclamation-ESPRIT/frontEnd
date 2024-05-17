import 'package:flutter/material.dart';
import 'package:reclamationapp/widgets/login/login_web_body.dart';

class LoginWebScreen extends StatelessWidget {
  final String? iconPath;
  const LoginWebScreen({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.3,
            child: Image.asset(iconPath!),
          ),
          const Expanded(child: LoginWebBody()),
        ],
      );
    });
  }
}
