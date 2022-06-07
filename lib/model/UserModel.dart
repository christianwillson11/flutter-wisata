import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String? uid;
  String? email;
  String? fullname;
  String? phone;

  UserModel({
    this.uid,
    this.email,
    this.fullname,
    this.phone
  });

  factory UserModel.fromMap(map){
    return UserModel(
      uid : map['uid'],
      email: map['email'],
      fullname: map['fullname'],
      phone : map['phone']
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'uid' : uid,
      'email' : email,
      'fullname' : fullname,
      'phone' : phone
    };
  }

}