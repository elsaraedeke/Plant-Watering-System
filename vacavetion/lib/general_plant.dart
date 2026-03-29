import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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

  Future<void> updateMoisture() async {
    var data = await fetchSensorData();
    percentMoisture = data;
  }

  static Future<int> fetchSensorData() async{
    final url = Uri.parse('http://192.69.152.190:5000/data');

    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data['analog'];
    }

    return -1;


  }

  void water() {
    lastWatered = DateTime.now();
    // also request to update moisture levels
  }


}