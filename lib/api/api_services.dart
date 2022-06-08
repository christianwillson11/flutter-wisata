import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter_wisata/model/MDestination.dart';

class Service {
  void getAllData() async {
     Map<String, String> requestHeaders = {
       "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com",
       "X-RapidAPI-Key": "f4f09eac2fmsh94c15e0aabf4c8ap119874jsn77c16249a0a7"
     };

    final response = await http.get(
      Uri.parse("https://travel-advisor.p.rapidapi.com/locations/search?query=jakarta&limit=30&offset=0&units=km&location_id=1&currency=USD&sort=relevance&lang=en_US"), headers: requestHeaders
    );

    // inspect(response);
    print(response.body.toString());
  }
}