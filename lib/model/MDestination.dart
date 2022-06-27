class DestinationAttractionData {
  String? cid;
  String? cnama;
  String? cdescription;
  String? caddress;
  String? cwebUrl;
  String? ctimezone;
  List? cimagesUrl;
  String? cimageUploadedDate;
  String? cphotoCaption;
  String? thumbnail;
  String? location;

  DestinationAttractionData({
    this.cid,
    this.cnama,
    this.cdescription,
    this.caddress,
    this.cwebUrl,
    this.ctimezone,
    this.cimagesUrl,
    this.cimageUploadedDate,
    this.cphotoCaption,
    this.thumbnail,
    this.location
  });

  // factory DestinationData.fromJson(Map<dynamic, dynamic> json) {
  //   return DestinationData(cid: json['location_id'], cnama: json['name']);
  // }
}

