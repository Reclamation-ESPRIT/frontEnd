import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:reclamationapp/Util/constant.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/models/user.dart';
import 'package:reclamationapp/screen/reclamation/reclamation_list.dart';

class UserServices {
  //Login
  Future<void> loginAdmin(
      BuildContext context, String email, String passsword) async {
    //var
    Uri uri = Uri.parse("$baseUrl/api/user/login");

    //headers
    var headers = {"Content-Type": "application/json"};
    //object
    var loginObject = {"email": email, "password": passsword};
    //request
    await http
        .post(uri, headers: headers, body: json.encode(loginObject))
        .then((response) async {
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, ReclamationScreen.routeName);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              contentPadding: const EdgeInsets.all(15),
              backgroundColor: AppTheme.darkSecondary,
              titleTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              contentTextStyle: const TextStyle(
                fontSize: 16,
              ),
              actionsPadding: EdgeInsets.zero,
              actionsAlignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.zero,
              title: const Text("Error"),
              content: const Text("Email or password incorrect"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                )
              ],
            );
          },
        );
      }
    });
  }

  Future<User> loginGoogle() async {
    //Default definition
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

//If current device is Web or Android, do not use any parameters except from scopes.
    if (kIsWeb || Platform.isAndroid) {
      googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
    }

//If current device IOS or MacOS, We have to declare clientID
//Please, look STEP 2 for how to get Client ID for IOS
    if (Platform.isIOS || Platform.isMacOS) {
      googleSignIn = GoogleSignIn(
        clientId:
            "429795609631-95dfoe6guqq8jsh08a5fv1n4jii4rftt.apps.googleusercontent.com",
        scopes: [
          'email',
        ],
      );
    }

    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    if (googleAccount == null) {
      return User();
    }
    return User(
      fullName: googleAccount.displayName,
      email: googleAccount.email,
      profilePicture: googleAccount.photoUrl,
    );
  }
}
