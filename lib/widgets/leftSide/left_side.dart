import 'package:flutter/material.dart';
import 'package:reclamationapp/Util/theme.dart';

class LeftSideWidget extends StatelessWidget {
  const LeftSideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth * 0.01,
          decoration: const BoxDecoration(color: AppTheme.lightPrimary),
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(color: AppTheme.lightBackground),
            child: Column(
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.1,
                  child: Image.asset(
                    "assets/images/LogoEsprit.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
