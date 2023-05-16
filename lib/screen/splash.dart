// ignore_for_file: camel_case_types

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../auth/login.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 500,
      splash: 'assets/images/Logo.png',
      nextScreen: const loginPage(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
