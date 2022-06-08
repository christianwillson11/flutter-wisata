class MDestination {
  String cid;
  String cavatar;
  String cnama;
  String calamat;
  String cemail;
  String cpekerjaan;
  String cquote;

  MDestination(
      {required this.cid,
      required this.cavatar,
      required this.cnama,
      required this.calamat,
      required this.cemail,
      required this.cpekerjaan,
      required this.cquote});

  factory MDestination.fromJson(Map<String, dynamic> json) {
    return MDestination(
      cid: json['id'],
      cnama: json['nama'],
      cavatar: json['avatar'],
      calamat: json['alamat'],
      cemail: json['email'],
      cpekerjaan: json['pekerjaan'],
      cquote: json['quote'],
    );
  }
}
