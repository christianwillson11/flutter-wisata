import 'dart:convert';
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
  Future<List<listHotel>> getDestinationID(String location, [String date = '2022-07-08']) async{
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
  
  Future<List<listHotel>> getHotelList(String destID, [String date = '2022-07-08']) async{
    Map<String, String> requestHeaders = {
    "X-RapidAPI-Host": "hotels4.p.rapidapi.com",
	  "X-RapidAPI-Key": "7d134ee662mshd76e7f6cb3143afp14c9a3jsn65351c2bde90"
  };
    var url = Uri.parse("https://hotels4.p.rapidapi.com/properties/list?destinationId=$destID&pageNumber=1&pageSize=25&checkIn=$date&checkOut=2022-07-09&adults1=1&starRatings=4&sortOrder=PRICE&locale=en_US&currency=IDR");
    final response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)["data"]["body"]["searchResults"]["results"];

      List <listHotel> hotelList = [];
      for (int i = 0; i < 24; i++) {
        var json = jsonResponse[i];

        var alamat;
        var hotelName;
        var rating;
        var locality;
        var gambar;

        try{
          hotelName = json["name"];
          alamat = json["address"]["streetAddress"];
          rating = json["starRating"];
          locality = json["address"]["locality"];
          gambar = json["optimizedThumbUrls"]["srpDesktop"];
        } catch (e){
          print("error");
        }
        hotelList.add(listHotel(hotelName: hotelName, alamat: alamat,rating: rating, locality: locality, gambar: gambar));
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
      throw Exception("failed to load data");
    }
  }

  Future<List<DestinationAttractionData>> getAttractionList(String query) async {
    var url = Uri.parse("https://travel-advisor.p.rapidapi.com/locations/search?query=$query&limit=30&offset=0&units=km&location_id=1&currency=USD&sort=relevance&lang=en_US");
    final response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var locId = json.decode(response.body)['data'][0]['result_object']['location_id'];
      Future<List<DestinationAttractionData>>  data = getAttractionData(locId.toString());
      return data;
      
    } else {
      throw Exception("failed to load data");
    }
  }

  //Destination
  Future<List<DestinationAttractionData>> getAttractionData(String locationId) async {
    // Jakarta
    final response = await http.get(
      Uri.parse("https://travel-advisor.p.rapidapi.com/attractions/list?location_id=$locationId&currency=IDR&lang=en_US&lunit=km&sort=recommended"), headers: requestHeaders
    );
    
    List<DestinationAttractionData> destinationDataList = [];

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      
      for (int i = 0; i<31; i++) {
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
          destinationDataList.add(DestinationAttractionData(cid: data['location_id'], cnama: data['name'], cdescription: data['description'], caddress: data['address'], cwebUrl: data['web_url'], ctimezone: data['timezone'], cimagesUrl: photosUrl, cimageUploadedDate: imgUploadedDate, cphotoCaption: imgCapt));
        }
      }

      // for (int i = 0; i<destinationDataList.length; i++) {
      //   print(destinationDataList[i].cnama.toString());
      // }
      
      
      return destinationDataList;
    } else {
      throw Exception("failed to load data");
    }
  }
}