import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color btnclr = Color.fromARGB(255, 0, 158, 97);
  static const LinearGradient bgclr = LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 248, 249, 255),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient bgsplash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.50, 1.0], // Controls where the transition starts and ends
    colors: [Colors.white, Color.fromRGBO(0, 178, 160, 0.2)],
  );
}
