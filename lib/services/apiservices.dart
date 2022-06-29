import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/model/hotelData.dart';
import 'package:flutter_wisata/model/weatherData.dart';

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
      return _simp;
    }else{
      throw('Failed to load Data');
    }

    //print(response.body.toString());
  }

  Future<bool> getStatus(String location) async {
    Map<String, String> requestHeaders = {
      "X-RapidAPI-Host": "community-open-weather-map.p.rapidapi.com",
	    "X-RapidAPI-Key": "2bf8da321dmsh17ce66024ac8067p1c5c94jsn7698a8baa3c0"
     };
    
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=d881571f5c62312c8f5d0ffbada6beee&units=metric'),
      headers: requestHeaders
    );

    if(response.statusCode == 200){
      return Future.value(true);
    }else{
      return Future.value(false);
    }
  }
}

class hotelService{
  
  Future<String> getCityID(String location, [String date='2022-07-08']) async {
    Map<String, String> requestHeaders = {
      "X-RapidAPI-Host": "hotels4.p.rapidapi.com",
	    "X-RapidAPI-Key": "2bf8da321dmsh17ce66024ac8067p1c5c94jsn7698a8baa3c0"
    };

    final response = await http.get(
      Uri.parse("https://hotels4.p.rapidapi.com/locations/v2/search?query=$location&locale=en_US&currency=IDR"),
      headers: requestHeaders
    );
    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      var _simp = jsonResponse["suggestions"][0]["entities"][0]["destinationId"];
      return _simp;
    } else {
      throw('Failed to load data');
    }
  }

  Future<List<listHotel>> getDestinationID(String location, [String date = '2022-07-08']) async{
    Map<String, String> requestHeaders = {
      "X-RapidAPI-Host": "hotels4.p.rapidapi.com",
	    "X-RapidAPI-Key": "2bf8da321dmsh17ce66024ac8067p1c5c94jsn7698a8baa3c0"
    };

    final response = await http.get(
      Uri.parse("https://hotels4.p.rapidapi.com/locations/v2/search?query=$location&locale=en_US&currency=IDR"),
      headers: requestHeaders
    );
    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      var _simp = jsonResponse["suggestions"][0]["entities"][0]["destinationId"];

      Future<List<listHotel>> data = getHotelList(_simp.toString());
      return data;
      //return _simp;
    }else{
      throw('Failed to provide city ID');
    }
  }
  
  Future<List<listHotel>> getHotelList(String destID, [String date = '2022-07-08']) async{
    Map<String, String> requestHeaders = {
    "X-RapidAPI-Host": "hotels4.p.rapidapi.com",
	  "X-RapidAPI-Key": "2bf8da321dmsh17ce66024ac8067p1c5c94jsn7698a8baa3c0"
  };
    var url = Uri.parse("https://hotels4.p.rapidapi.com/properties/list?destinationId=$destID&pageNumber=1&pageSize=25&checkIn=$date&checkOut=2022-07-09&adults1=1&starRatings=4&sortOrder=PRICE&locale=en_US&currency=IDR");
    final response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)["data"]["body"]["searchResults"]["results"];

      List <listHotel> hotelList = [];
      for (int i = 0; i < jsonResponse.length; i++) {
        var json = jsonResponse[i];

        var id;
        var alamat;
        var hotelName;
        var rating;
        var locality;
        var gambar;
        var price;

        try{
          id = json["id"];
          hotelName = json["name"];
          alamat = json["address"]["streetAddress"];
          rating = json["starRating"];
          locality = json["address"]["locality"];
          gambar = json["optimizedThumbUrls"]["srpDesktop"];
          price = json["ratePlan"]["price"]["current"];

        } catch (e){
          // print("error");
        }
        hotelList.add(listHotel(id: id.toString(), hotelName: hotelName, alamat: alamat,rating: rating, locality: locality, gambar: gambar, price: price));
      }
      return hotelList;
    }
    else{
      throw ("Failed to load data");
    }
  }
}

class DestinationApiService {
  Map<String, String> requestHeaders = {
    "X-RapidAPI-Key": "f4f09eac2fmsh94c15e0aabf4c8ap119874jsn77c16249a0a7",
    "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com"
  };
  
  Future<String> getLocId(String query) async {
    var url = Uri.parse("https://travel-advisor.p.rapidapi.com/locations/search?query=$query&limit=30&offset=0&units=km&location_id=1&currency=USD&sort=relevance&lang=en_US");
    final response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var locId = json.decode(response.body)['data'][0]['result_object']['location_id'];
      return locId;
      
    } else {
      throw('Failed to provide city ID');
    }
  }

  //Destination
  Future<List<DestinationAttractionData>> getAttractionData(String cityId) async {
    // Jakarta
    final response = await http.get(
      Uri.parse("https://travel-advisor.p.rapidapi.com/attractions/list?location_id=$cityId&currency=IDR&lang=en_US&lunit=km&sort=recommended"), headers: requestHeaders
    );
    
    List<DestinationAttractionData> destinationDataList = [];

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      
      for (int i = 0; i<jsonResponse.length; i++) {
        var data = jsonResponse[i];
        List photosUrl = [];
        // ignore: prefer_typing_uninitialized_variables
        var imgUploadedDate;
        // ignore: prefer_typing_uninitialized_variables
        var imgCapt;
        try {
          photosUrl.add(data['photo']['images']['original']['url']);
          photosUrl.add(data['photo']['images']['large']['url']);
          imgUploadedDate = data['photo']['uploaded_date'];
          imgCapt = data['photo']['caption'];
        } catch (e) {
          // print("error");
        }

        if (data['name'] != null) {
          destinationDataList.add(DestinationAttractionData(cid: data['location_id'], cnama: data['name'], cdescription: data['description'], caddress: data['address'], cwebUrl: data['web_url'], ctimezone: data['timezone'], cimagesUrl: photosUrl, cimageUploadedDate: imgUploadedDate, cphotoCaption: imgCapt, thumbnail: data['photo']['images']['original']['url'], location: data['location_string']));
        }
      }
      
      
      return destinationDataList;
    } else {
      throw ("Failed to load data");
    }
  }
}