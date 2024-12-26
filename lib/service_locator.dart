import 'package:get_it/get_it.dart';
import 'package:weather_app/services/weather_service.dart';

GetIt locator = GetIt.instance;

serviceLocator() {
  locator.registerLazySingleton<WeatherService>(
      () => WeatherService(apiKey: '304d3c4e1a4a5bc9ab1f59a28c0e501e'));
}
