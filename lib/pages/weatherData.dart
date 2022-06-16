class Weather {
  String cityName;
  double temp;
  double feels;
  double wind;
  int humidity;
  int pressure;
  int visibility;

  Weather(
      {required this.cityName,
      required this.temp,
      required this.feels,
      required this.wind,
      required this.humidity,
      required this.pressure,
      required this.visibility});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"],
      temp: json["main"]["temp"],
      feels: json["main"]["feels_like"],
      wind: json["wind"]["speed"],
      humidity: json["main"]["humidity"],
      pressure: json["main"]["pressure"],
      visibility: json["visibility"]
    );
  }
}
