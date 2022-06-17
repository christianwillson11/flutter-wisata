import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/services/dbservices.dart';
import 'package:image_picker/image_picker.dart';

class InputCerita extends StatefulWidget {
  final idContext;
  final context;
  const InputCerita({Key? key, required this.idContext, required this.context}) : super(key: key);

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
  // Service ServiceAPIDestinasi = Service();

  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  List<String> _arrImageUrl = [];

  int uploadItem = 0;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("${widget.idContext.toString()}"),
        ),
        body: SingleChildScrollView(
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
                        height: 300,
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
                            image: _arrImageUrl,
                            owner: "owner");
                        uploadFunction(_selectedFiles, dt);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void uploadFunction(List<XFile> _images, StoriesItem dt) {
    if (dt.judulCerita == "" || dt.isiCerita == "") {
      print("ERROR!");
    } else {
      for (int i = 0; i < _images.length; i++) {
        var imageUrl = Database.uploadFile(image: _images[i]);
        _arrImageUrl.add(imageUrl.toString());
      }
      Database.insertData(item: dt);
    }
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
