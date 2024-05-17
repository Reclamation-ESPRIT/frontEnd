import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reclamationapp/Util/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme = _lightTheme;

  static final ThemeData _lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.lightBackground,
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: AppTheme.lightPrimary,
        ),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData _darkTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.darkBackground,
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: AppTheme.lightPrimary,
        ),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  void toggleTheme() {
    currentTheme = currentTheme == _lightTheme ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: const BorderSide(color: Color.fromRGBO(214, 218, 226, 1)),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    displayLarge: TextStyle(
        fontSize: 72.0, fontWeight: FontWeight.normal, fontFamily: 'Poppins'),
    displayMedium: TextStyle(
        fontSize: 36.0, fontWeight: FontWeight.normal, fontFamily: 'Poppins'),
    displaySmall: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Poppins'),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    titleTextStyle: TextStyle(fontSize: 16, color: Colors.black),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: Colors.black),
  );
}
