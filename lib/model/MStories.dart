class StoriesItem {
  final String locationId;
  final String judulCerita;
  final String isiCerita;
  final String image;
  final String owner;

  StoriesItem ({
    required this.locationId,
    required this.judulCerita,
    required this.isiCerita,
    required this.image,
    required this.owner,
  });

  Map<String, dynamic> toJson() {
    return {
      "locationId": locationId,
      "judulCerita": judulCerita,
      "isiCerita": isiCerita,
      "image": image,
      "owner": owner
    };
  }

  factory StoriesItem.fromJson(Map<String, dynamic> json) {
    return StoriesItem(locationId: json['locationId'], judulCerita: json['judulCerita'], isiCerita: json['isiCerita'], image: json['image'], owner: json['owner']);
  }
}