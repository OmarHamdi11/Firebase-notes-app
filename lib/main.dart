import 'dart:developer';

import 'package:firebase_project/views/home_view.dart';
import 'package:firebase_project/auth/intro_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> User is currently signed out!');
      } else {
        log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.shipporiMinchoTextTheme(
          ThemeData.light().textTheme,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade200,
            titleTextStyle: const TextStyle(
                color: Colors.orange,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            iconTheme: const IconThemeData(color: Colors.orange)),
      ),
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const HomeView()
          : const IntroView(),
    );
  }
}
