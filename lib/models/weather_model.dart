class Weather {
  dynamic cityName;
  dynamic humidity;
  dynamic mainCondition;
  dynamic temperature;
  String description;
  Weather({
    required this.cityName,
    required this.humidity,
    required this.temperature,
    required this.mainCondition,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      humidity: json['main']['humidity'],
      temperature: json['main']['temp'],
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }
}
