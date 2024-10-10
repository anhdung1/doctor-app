import 'package:flutter/material.dart';

var gradient = const LinearGradient(
    colors: [
      Color.fromRGBO(220, 229, 255, 1),
      Colors.white,
      Colors.white,
      Color.fromRGBO(220, 229, 255, 1),
    ],
    stops: [
      0.1,
      0.4,
      0.6,
      0.9
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(-0.3));
Color colorButton = const Color.fromARGB(255, 33, 163, 133);
var homeTheme = const BoxDecoration(
    gradient: LinearGradient(colors: [
  Color.fromRGBO(207, 240, 255, 0.718),
  Color.fromARGB(255, 248, 248, 248),
  Color.fromARGB(255, 248, 248, 248),
  Color.fromRGBO(207, 240, 255, 0.718),
], stops: [
  0,
  0.4,
  0.8,
  1
], begin: Alignment.topLeft, end: Alignment.bottomRight));
var titleStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
