import 'dart:ui';

import 'package:flutter/material.dart';

Color colorButton = const Color.fromARGB(255, 33, 163, 133);
var homeTheme = const BoxDecoration(
    gradient: LinearGradient(colors: [
  Color.fromRGBO(178, 255, 236, 0.718),
  Color.fromRGBO(0, 0, 0, 0.04),
  Color.fromRGBO(0, 0, 0, 0.04),
  Color.fromRGBO(178, 255, 236, 0.718),
], stops: [
  0,
  0.4,
  0.8,
  1
], begin: Alignment.topLeft, end: Alignment.bottomRight));
var titleStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
Set<PointerDeviceKind> dragDevices = {
  PointerDeviceKind.mouse,
  PointerDeviceKind.touch
};
String ip = "localhost";
