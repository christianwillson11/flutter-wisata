import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/api/api_services.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/services/dbservices.dart';
import 'package:image_picker/image_picker.dart';

class InputCerita extends StatefulWidget {
  const InputCerita({Key? key}) : super(key: key);

  @override
  State<InputCerita> createState() => _InputCeritaState();
}

class _InputCeritaState extends State<InputCerita> {
  final _judulCerita = TextEditingController();
  final _isiCerita = TextEditingController();
  @override
  void dispose() {
    _judulCerita.dispose();
    _isiCerita.dispose();
    super.dispose();
  }

  //services
  Service ServiceAPIDestinasi = Service();

  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  FirebaseStorage _storageRef = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(8, 50, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _judulCerita,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.try_sms_star_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelText: "Judul Cerita Anda"),
                ),
                SizedBox(
                  height: 22,
                ),
                TextField(
                  controller: _isiCerita,
                  maxLines: 8,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.try_sms_star_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    labelText: "Isi Cerita Anda",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    selectImage();
                  },
                  child: Text("Select Photos"),
                ),
                if (_selectedFiles.length == null)
                  Text("No Images Selected")
                else
                  SizedBox(
                    height: 600,
                    child: Expanded(
                      child: GridView.builder(
                          itemCount: _selectedFiles.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(2),
                              child: Image.file(
                                File(_selectedFiles[index].path),
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                    ),
                  ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    // final CurvedNavigationBarState? navBarState =
                    //     _bottomNavigationKey.currentState;
                    // navBarState?.setPage(1);
                    // ServiceAPIDestinasi.getAllData();

                    final dt = StoriesItem(
                        locationId: "12345",
                        judulCerita: _judulCerita.text.toString(),
                        isiCerita: _isiCerita.text.toString(),
                        image: "Ini image",
                        owner: "owner");
                    Database.insertData(item: dt);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectImage() async {
    if (_selectedFiles != null) {
      _selectedFiles.clear();
    }

    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images!.isNotEmpty) {
        _selectedFiles.addAll(images);
      }
      print("List of selected images: " + images.length.toString());
    } catch (e) {
      print(e);
    }
    setState(() {});
  }
}
