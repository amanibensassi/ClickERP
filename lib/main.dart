import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/api/firebase_api.dart';
import 'package:notification/constants.dart';
import 'package:notification/firebase_options.dart';
import 'package:notification/pages/page_erreur.dart';
import 'pages/connexion.dart';
import 'package:firebase_core/firebase_core.dart';

final navigatorkey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Click-erp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
      navigatorKey: navigatorkey,
      home: const Connexion(),
      routes: {
        Page404.route: (context) => const Page404(),
      },
    );
  }
}
