import 'package:flutter/material.dart';

clipImage(imageUrl) {
  return AspectRatio(
    aspectRatio: 1 / 1,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        imageUrl,
        alignment: Alignment.topCenter,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/images/default.png",
            // width: 60,
            errorBuilder: (context, error, stackTrace) {
              return const Text("error");
            },
          );
        },
      ),
    ),
  );
}

imageButton(imageUrl, onTap) {
  return InkWell(
    onTap: onTap,
    child: AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          imageUrl,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/default.png",
              width: 60,
              errorBuilder: (context, error, stackTrace) {
                return const Text("error");
              },
            );
          },
        ),
      ),
    ),
  );
}
