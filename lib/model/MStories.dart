class StoriesItem {
  final String locationId;
  final String cityId;
  final String judulCerita;
  final String isiCerita;
  final List<String> image;
  final String owner;
  final String category;

  StoriesItem ({
    required this.locationId,
    required this.cityId,
    required this.judulCerita,
    required this.isiCerita,
    required this.image,
    required this.owner,
    required this.category
  });

  Map<String, dynamic> toJson() {
    return {
      "locationId": locationId,
      "cityId": cityId,
      "judulCerita": judulCerita,
      "isiCerita": isiCerita,
      "image": image,
      "owner": owner,
      "category": category
    };
  }

  factory StoriesItem.fromJson(Map<String, dynamic> json) {
    return StoriesItem(locationId: json['locationId'], cityId: json['cityId'], judulCerita: json['judulCerita'], isiCerita: json['isiCerita'], image: json['image'], owner: json['owner'], category: json['category']);
  }
}