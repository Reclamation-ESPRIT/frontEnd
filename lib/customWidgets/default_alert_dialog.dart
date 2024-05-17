// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:reclamationapp/Util/theme.dart';

class DefaultAlertDialog extends StatelessWidget {
  //var
  final String title;
  final String body;
  late String defaultActionTitle;
  late VoidCallback defaultAction;
  late String secondaryActionTitle;
  late VoidCallback secondaryAction;
  bool singleAction = false;
  bool doubleAction = false;

  DefaultAlertDialog.info(this.title, this.body, {super.key});
  DefaultAlertDialog.singleAction(
      this.title, this.body, this.defaultActionTitle, this.defaultAction,
      {super.key}) {
    singleAction = true;
  }
  DefaultAlertDialog.doubleAction(
      this.title,
      this.body,
      this.defaultActionTitle,
      this.defaultAction,
      this.secondaryActionTitle,
      this.secondaryAction,
      {super.key}) {
    doubleAction = true;
  }

  //actions

  //Build
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              body,
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          doubleAction
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: defaultAction,
                      child: Text(
                        defaultActionTitle,
                        style: const TextStyle(
                            color: AppTheme.lightPrimary, fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton(
                      onPressed: secondaryAction,
                      child: Text(
                        secondaryActionTitle,
                        style: const TextStyle(
                            color: AppTheme.lightPrimary, fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    singleAction
                        ? TextButton(
                            onPressed: defaultAction,
                            child: Text(
                              defaultActionTitle,
                              style: const TextStyle(
                                  color: AppTheme.lightPrimary, fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                  color: AppTheme.lightPrimary, fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                          )
                  ],
                ),
        ],
      ),
    );
  }
}
