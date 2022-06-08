import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String? uid;
  String? email;
  String? fullname;
  String? phone;
  String? birthday;

  UserModel({
    this.uid,
    this.email,
    this.fullname,
    this.phone,
    this.birthday
  });

  factory UserModel.fromMap(map){
    return UserModel(
      uid : map['uid'],
      email: map['email'],
      fullname: map['fullname'],
      phone : map['phone'],
      birthday : map['birthday']
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'uid' : uid,
      'email' : email,
      'fullname' : fullname,
      'phone' : phone,
      'birthday' : birthday
    };
  }

}