import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherViewModel();
  final _weatherService =
      WeatherService(apiKey: '304d3c4e1a4a5bc9ab1f59a28c0e501e');

  initView() async {
    await fetchWeather();
    await fetchSpecificCityWeather();
  }

  final TextEditingController _searchCity = TextEditingController();
  TextEditingController get searchCityController => _searchCity;

  Weather? _weather;

  Weather? get weather => _weather;
  Weather? _specificCityWeather;
  Weather? get specificCityWeather => _specificCityWeather;
  Future fetchWeather() async {
    String cityName = await _weatherService.getCurrenCityName();
    _weather = await _weatherService.getCityWeather(cityName: cityName);
    notifyListeners();
  }

  Future fetchSpecificCityWeather() async {
    if (_searchCity.text.isNotEmpty || _searchCity.text != '') {
      String cityName = _searchCity.text.toLowerCase();
      _specificCityWeather =
          await _weatherService.getCityWeather(cityName: cityName);
    } else {
      final cName = await _weatherService.getCurrenCityName();
      _specificCityWeather =
          await _weatherService.getCityWeather(cityName: cName);
    }
    notifyListeners();
  }

  String getWeatherImage({String? mainCondition}) {
    if (mainCondition == null) return 'Assets/Lottie/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'smoke':
      case 'mist':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'Assets/Lottie/cluds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'Assets/Lottie/rains.json';
      case 'thunderstorm':
        return 'Assets/Lottie/lightining.json';
      case 'clear':
        return 'Assets/Lottie/sunny.json';
      default:
        return 'Assets/Lottie/sunny.json';
    }
  }
}
