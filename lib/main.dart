import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reclamationapp/Util/providers.dart';
import 'package:reclamationapp/Util/routes.dart';
import 'package:reclamationapp/screen/SplashScreen/splash_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
