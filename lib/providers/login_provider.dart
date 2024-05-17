import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String _mailSender = "";

  String getMailSender() => _mailSender;
  void setMailSender(String mailSender) {
    _mailSender = mailSender;
    notifyListeners();
  }
}
