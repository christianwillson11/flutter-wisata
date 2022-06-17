import 'dart:convert';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/model/MPlace.dart';  
import 'package:http/http.dart' as http;

class DestinationApiService {
  Map<String, String> requestHeaders = {
    "X-RapidAPI-Key": "f4f09eac2fmsh94c15e0aabf4c8ap119874jsn77c16249a0a7",
    "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com"
  };
  
  Future<List<PlaceData>> getPlaceData(String query) async {
    var url = Uri.parse("https://travel-advisor.p.rapidapi.com/locations/search?query=$query&limit=30&offset=0&units=km&location_id=1&currency=USD&sort=relevance&lang=en_US");
    final response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      
      List<PlaceData> placeDataList = [];
      
      for (int i = 0; i<5; i++) {
        var json = jsonResponse[i];

        var id;
        var name;
        var desc;
        var locationString;

        try {
          id = json['result_object']['location_id'];
          name = json['result_object']['name'];
          locationString = json['result_object']['location_string'];
          desc = json['result_object']['description'];
        } catch (e) {
          print("error");
        }

        placeDataList.add(PlaceData(cid: id, cnama: name, clocationString: locationString, cdesc: desc));
      }
      return placeDataList;
    } else {
      throw Exception("failed to load data");
    }
  }

  Future<List> getAttractionData(String locationId) async {
    // Jakarta
    final response = await http.get(
      Uri.parse("https://travel-advisor.p.rapidapi.com/attractions/list?location_id=$locationId&currency=IDR&lang=en_US&lunit=km&sort=recommended"), headers: requestHeaders
    );
    
    List destinationDataList = [];

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

        destinationDataList.add(DestinationData(cid: data['location_id'], cnama: data['name'], cdescription: data['description'], caddress: data['address'], cwebUrl: data['web_url'], ctimezone: data['timezone'], cimagesUrl: photosUrl, cimageUploadedDate: imgUploadedDate, cphotoCaption: imgCapt));
      }

      for (int i = 0; i<destinationDataList.length; i++) {
        print(destinationDataList[i].cnama.toString());
        print(destinationDataList[i].cdescription.toString());
        print(destinationDataList[i].cwebUrl.toString());
      }
      
      
      return destinationDataList;
    } else {
      throw Exception("failed to load data");
    }
  }
}