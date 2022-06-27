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
  String? id;
  String? hotelName;
  String? alamat;
  double? rating;
  String? locality;
  String? gambar;
  String? price;
  
  listHotel({
    this.id,
    this.hotelName,
    this.alamat,
    this.rating,
    this.locality,
    this.gambar,
    this.price
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