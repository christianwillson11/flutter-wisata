import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/model/UserModel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

CollectionReference tblCerita = FirebaseFirestore.instance.collection("stories");
FirebaseStorage _storageRef = FirebaseStorage.instance;

class Database {
  static Stream<QuerySnapshot> getAllData () {
    return tblCerita
    .where("owner", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots();
  }

  static Stream<QuerySnapshot> getData(String whereClause) {
    return tblCerita
    .where("locationId", isEqualTo: whereClause)
    .snapshots();
  }

  static Future<bool> insertData({required StoriesItem item}) async {
    DocumentReference docRef = tblCerita.doc();

    bool success = false;

    await docRef
    .set(item.toJson())
    .whenComplete(() => success = true)
    .catchError((e) => success = false);
    return success;
  }

  static Future<String> uploadFile({required XFile image}) async {
    Reference reference = _storageRef.ref().child("story_images").child(image.name);
    UploadTask uploadTask = reference.putFile(File(image.path));
    
    await uploadTask
    .whenComplete(() => print(reference.getDownloadURL()));

    return await reference.getDownloadURL();
  }
}