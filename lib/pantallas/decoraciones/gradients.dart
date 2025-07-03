import 'package:flutter/material.dart';

class Gradients {
  static const LinearGradient blue1 = LinearGradient(
    colors: [Color(0xff2193b0), Color(0xff6dd5ed)],
    stops: [0, 1],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );

  static const LinearGradient blue2 = LinearGradient(
    colors: [Color(0xff2193b0), Color(0xff6dd5ed)],
    stops: [0, 1],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient blue3 = LinearGradient(
    colors: [Color(0xff00fff0), Color(0xff0083fe)],
    stops: [0, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const SweepGradient gray1 = SweepGradient(
    colors: [
      Color.fromARGB(255, 98, 104, 126),
      Color.fromARGB(255, 192, 196, 205),
    ],
    stops: [0, 1],
    center: Alignment.bottomLeft,
  );
}
