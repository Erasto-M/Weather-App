import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  WeatherService({required this.apiKey});
  final String apiKey;
  String errMessage = '';
  Future<Weather> getCityWeather({required String cityName}) async {
    try {
      const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
      final endpoint = '$baseUrl?q=$cityName&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        debugPrint('error status code ${response.statusCode}');
        throw Exception(response.statusCode);
      }
    } catch (e) {
      errMessage = e.toString();
      throw Exception(e.toString());
    }
  }

  Future<String> getCurrenCityName() async {
    try {
      //request permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      //fetch current location
      Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));

      //get place marks
      List<Placemark> places =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String? city = places[0].locality;
      return city ?? '';
    } catch (e) {
      errMessage = e.toString();
      throw Exception(e.toString());
    }
  }
}
