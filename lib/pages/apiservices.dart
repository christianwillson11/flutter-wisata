import 'dart:convert';

import 'package:flutter_wisata/pages/weatherData.dart';
import 'package:http/http.dart' as http;

class service{
  Future<Weather> getWeatherData(String location) async {
    Map<String, String> requestHeaders = {
      "X-RapidAPI-Host": "community-open-weather-map.p.rapidapi.com",
	    "X-RapidAPI-Key": "2bf8da321dmsh17ce66024ac8067p1c5c94jsn7698a8baa3c0"
     };
    
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=d881571f5c62312c8f5d0ffbada6beee&units=metric'),
      headers: requestHeaders
    );

    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      Weather _simp = Weather.fromJson(jsonResponse);
      print(_simp.cityName);
      return _simp;
      // List jsonResponse = json.decode(response.body);
      // return jsonResponse.map((data) => Weather.fromJson(data)).toList();
    }else{
      throw('Failed to load Data');
    }

    //print(response.body.toString());
  }
}