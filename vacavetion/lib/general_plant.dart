import 'dart:core';
import 'package:flutter/material.dart';


class GeneralPlant {
  late String name;
  late int percentMoisture;
  late DateTime lastWatered;

  GeneralPlant(String n) {
    name = n;
    percentMoisture = 0;
    lastWatered = DateTime.now();
  }

  GeneralPlant.currentTime(String n, int pMoisture) {
    name = n;
    percentMoisture = pMoisture;
    lastWatered = DateTime.now();
  }

  Map<String, dynamic> createPlant() {
    return {
      'name': name,
      'percentMoisture': percentMoisture,
      'lastWatered': lastWatered
    };


  }
}