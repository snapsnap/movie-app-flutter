import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(32, 83, 84, 1);
const Color errorColor = Color.fromRGBO(255, 76, 76, 1);
const Color warningColor = Color.fromRGBO(255, 185, 79, 1);

final colorStatus = {
  "0": Colors.blue.shade200,
  "1": Colors.green.shade200,
  "2": Colors.red.shade200,
  "3": Colors.amber.shade200,
};

final colorBootstrap = {
  "": {
    "color": Colors.white,
    "isTextOnDark": false,
  },
  "0": {
    "color": Colors.amber,
    "isTextOnDark": false,
  },
  "1": {
    "color": Colors.lightBlue.shade200,
    "isTextOnDark": false,
  },
  "2": {
    "color": Colors.black,
    "isTextOnDark": true,
  },
  "3": {
    "color": const Color.fromARGB(255, 116, 116, 116),
    "isTextOnDark": true,
  },
  "4": {
    "color": const Color.fromARGB(255, 21, 158, 25),
    "isTextOnDark": true,
  },
  "5": {
    "color": Colors.red,
    "isTextOnDark": true,
  },
  "6": {
    "color": const Color.fromARGB(255, 10, 109, 190),
    "isTextOnDark": true,
  },
};
