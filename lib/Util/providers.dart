import 'package:provider/provider.dart';
import 'package:reclamationapp/providers/login_provider.dart';
import 'package:reclamationapp/providers/reclamation.dart';

dynamic providers = [
  //exemple provider
  // ChangeNotifierProvider(
  //   create: (context) => UserProvider(),
  // ),

  //Themes provider

  ChangeNotifierProvider(
    create: (context) => LoginProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ReclamationsProvider(),
  ),
];
