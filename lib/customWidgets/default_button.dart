import 'package:flutter/material.dart';
import 'package:reclamationapp/Util/constant.dart';

// ignore: must_be_immutable
class DefaultButton extends StatelessWidget {
  //var
  final String title;
  final VoidCallback action;
  late Widget icon;
  bool isIconButton = false;
  //Constructor
  DefaultButton(this.title, this.action, {super.key});
  DefaultButton.icon(this.title, this.action, this.icon, {super.key}) {
    isIconButton = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: action,
        child: Container(
          height: height() * 0.05,
          width: width() * 0.57,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient:
                  const LinearGradient(begin: Alignment.centerLeft, stops: [
                0.1,
                0.9
              ], colors: [
                Color.fromRGBO(203, 0, 24, 1),
                Color.fromRGBO(88, 82, 80, 1),
              ])),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isIconButton
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: icon,
                      )
                    : const SizedBox(),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
