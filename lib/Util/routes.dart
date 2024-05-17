import 'package:reclamationapp/screen/SplashScreen/splash_screen.dart';
import 'package:reclamationapp/screen/auth/login.dart';
import 'package:reclamationapp/screen/reclamation/manage_reclamation.dart';
import 'package:reclamationapp/screen/reclamation/reclamation_add.dart';
import 'package:reclamationapp/screen/reclamation/reclamation_list.dart';
import 'package:reclamationapp/screen/reclamation/reclamation_list_mobile.dart';

var routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  // ignore: equal_keys_in_map
  LoginScreen.routeName: (context) => const LoginScreen(),
  ReclamationScreen.routeName: (context) => const ReclamationScreen(),
  ReclamationScreenMobile.routeName: (context) =>
      const ReclamationScreenMobile(),

  AddReclamationScreen.routeName: (context) => const AddReclamationScreen(),
  ManageReclamationScreen.routeName: (context) =>
      const ManageReclamationScreen(),
};
