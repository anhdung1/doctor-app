import 'package:flutter/material.dart';

appBar(BuildContext context, String title) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    // shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    leading: Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 14,
          ),
        ),
      ),
    ),
  );
}
