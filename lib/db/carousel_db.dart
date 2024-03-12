import 'dart:convert';
import 'package:flutter/services.dart';

class GetJSON{
  Future<void> readJson() async {
    List slides = [];
    final String response = await rootBundle.loadString('assets/json/carousel.json');
    final data = await json.decode(response);
    slides = data['carousel'];
  }
}

