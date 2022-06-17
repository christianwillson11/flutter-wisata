class Hotel{
  String? geoID;
  String? alamat;

  Hotel({
    this.geoID, this.alamat
    }
  );

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      //geoID : json["term"],
      geoID : json["suggestions"][0]["entities"][0]["destinationId"],
    );

  }
}

class listHotel{
  String? geoID;
  String? hotelName;
  String? alamat;
  
  listHotel({
    this.geoID,
    this.hotelName,
    this.alamat
    });

  factory listHotel.fromJson(Map<String, dynamic> json) {
    int index = 0;
    index = index + 1;
    return listHotel(
      //geoID : json["term"],
      
      hotelName : json["data"]["body"]["searchResults"]["results"][0]["name"],
    );
    
  }
}