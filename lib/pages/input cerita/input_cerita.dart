import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/services/dbservices.dart';
import 'package:image_picker/image_picker.dart';

class InputCerita extends StatefulWidget {
  final String idCity;
  final String idContext;
  final String konteks;
  const InputCerita({Key? key, required this.idCity, required this.idContext, required this.konteks}) : super(key: key);

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

  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  List<String> _arrImageUrl = [];

  int uploadItem = 0;
  bool _isUploading = false;

  void uploadFunction(List<XFile> _images, StoriesItem dt) async {
    setState(() {
      _isUploading = true;
    });
    var msg = "";
    if (dt.judulCerita == "" || dt.isiCerita == "") {
      msg = "Gagal menginput cerita. Harap lengkapi semua data";
      final snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      for (int i = 0; i < _images.length; i++) {
        var imageUrl = await Database.uploadFile(image: _images[i]);
        _arrImageUrl.add(imageUrl.toString());
      }
      Database.insertData(item: dt);
      var msg = "Berhasil menginput data!";
      final snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        Navigator.pop(context);
      });
    }
    
  }

  Future<void> selectImage() async {

    var msg = "";
    
    if (_selectedFiles != null) {
      _selectedFiles.clear();
    }

    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images!.isNotEmpty) {
        _selectedFiles.addAll(images);
      }
    } catch (e) {
      msg = e.toString();
      final snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }

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
                    const SizedBox(
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
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        selectImage();
                      },
                      child: const Text("Select Photos"),
                    ),
                    if (_selectedFiles.length == null)
                      const Text("No Images Selected")
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
                                  padding: const EdgeInsets.all(2),
                                  child: Image.file(
                                    File(_selectedFiles[index].path),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        if (_isUploading == false) {
                          final dt = StoriesItem(
                            cityId: widget.idCity,
                            locationId: widget.idContext,
                            judulCerita: _judulCerita.text.toString(),
                            isiCerita: _isiCerita.text.toString(),
                            image: _arrImageUrl,
                            owner: "owner",
                            category: widget.konteks
                            );
                        uploadFunction(_selectedFiles, dt);
                        } else {
                          null;
                        }
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
}
