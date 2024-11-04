import 'package:flutter/material.dart';

titleName(title) {
  return Padding(
    padding: const EdgeInsets.only(top: 130, bottom: 15, left: 10, right: 10),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    ),
  );
}

content() {
  return const Padding(
    padding: EdgeInsets.only(left: 20, right: 20, bottom: 60),
    child: Text(
      "You can search course, apply course and find scholarship for abroad studies",
      style: TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
    ),
  );
}

loginWith(asset, name) {
  return Expanded(
    child: InkWell(
      onTap: () {},
      child: Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0.5,
            )
          ], borderRadius: BorderRadius.circular(7), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                asset,
                width: 18,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(name)
            ],
          )),
    ),
  );
}

sectionTitle(name, buttonName, onTap) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, top: 20, bottom: 10, right: 15),
    child: Row(
      children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        const Expanded(child: SizedBox()),
        InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: onTap,
            child: Text(
              buttonName,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue[400]),
            ))
      ],
    ),
  );
}

textField(controller, hintText, hide, prefixIcon) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    // width: MediaQuery.of(context).size.width - 30,
    height: 54,
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: hide,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
      controller: controller,
    ),
  );
}

textButton(onTap, content) {
  return InkWell(
    onTap: onTap,
    child: Text(
      content,
      style: const TextStyle(
          color: Color.fromARGB(255, 33, 163, 133),
          fontSize: 14,
          fontWeight: FontWeight.w600),
    ),
  );
}
