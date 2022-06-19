import 'dart:convert';
import 'dart:math';

import 'package:flutter_wisata/pages/hotelData.dart';
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

class hotelService{
  Future<List<listHotel>> getDestinationID(String location) async{
    Map<String, String> requestHeaders = {
      "X-RapidAPI-Host": "hotels4.p.rapidapi.com",
	    "X-RapidAPI-Key": "7d134ee662mshd76e7f6cb3143afp14c9a3jsn65351c2bde90"
    };

    final response = await http.get(
      Uri.parse("https://hotels4.p.rapidapi.com/locations/v2/search?query=$location&locale=en_US&currency=IDR"),
      headers: requestHeaders
    );
    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      var _simp = jsonResponse["suggestions"][0]["entities"][0]["destinationId"];
      print(_simp);
      Future<List<listHotel>> data = getHotelList(_simp.toString());
      return data;
      //return _simp;
    }else{
      throw('Failed to load Data');
    }
  }
  
  Future<List<listHotel>> getHotelList(String destID) async{
    Map<String, String> requestHeaders = {
    "X-RapidAPI-Host": "hotels4.p.rapidapi.com",
	  "X-RapidAPI-Key": "7d134ee662mshd76e7f6cb3143afp14c9a3jsn65351c2bde90"
  };
    var url = Uri.parse("https://hotels4.p.rapidapi.com/properties/list?destinationId=$destID&pageNumber=1&pageSize=25&checkIn=2022-07-08&checkOut=2022-07-09&adults1=1&sortOrder=PRICE&locale=en_US&currency=IDR");
    final response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)["data"]["body"]["searchResults"]["results"];

      List <listHotel> hotelList = [];
      for (int i = 0; i < 24; i++) {
        var json = jsonResponse[i];

        var alamat;
        var hotelName;

        try{
          hotelName = json["name"];
          alamat = json["address"]["streetAddress"];
        } catch (e){
          print("error");
        }
        hotelList.add(listHotel(hotelName: hotelName, alamat: alamat));
      }
      return hotelList;
    }
    else{
      throw Exception("failed to load data");
    }
  }
}

class hotelData{
  Future<List<listHotel>> getHotelList(String destID) async{
    Map<String, String> requestHeaders = {
    "X-RapidAPI-Host": "hotels4.p.rapidapi.com",
	  "X-RapidAPI-Key": "7d134ee662mshd76e7f6cb3143afp14c9a3jsn65351c2bde90"
  };
    var url = Uri.parse("https://hotels4.p.rapidapi.com/properties/list?destinationId=$destID&pageNumber=1&pageSize=25&checkIn=2022-07-08&checkOut=2022-07-09&adults1=1&sortOrder=PRICE&locale=en_US&currency=IDR");
    final response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)["data"]["body"]["searchResults"]["results"];

      List <listHotel> hotelList = [];
      for (int i = 0; i<5; i++) {
        var json = jsonResponse[i];

        var alamat;
        var hotelName;

        try{
          hotelName = json["name"];
          alamat = json["address"]["streetAddress"];
        } catch (e){
          print("error");
        }
        hotelList.add(listHotel(hotelName: hotelName, alamat: alamat));
      }
      return hotelList;
    }
    else{
      throw Exception("failed to load data");
    }
  }
}