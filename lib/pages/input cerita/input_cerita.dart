// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/services/dbservices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class InputCerita extends StatefulWidget {
  final String idCity;
  final String idContext;
  final String konteks;
  const InputCerita(
      {Key? key,
      required this.idCity,
      required this.idContext,
      required this.konteks})
      : super(key: key);

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
    if (_images.isNotEmpty) {
      setState(() {
        _isUploading = true;
      });
      if (dt.judulCerita == "" || dt.isiCerita == "") {
        Fluttertoast.showToast(
            msg: "Gagal Menambahkan cerita. Harap lengkapi data",
            toastLength: Toast.LENGTH_LONG);
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
    } else {
      Fluttertoast.showToast(
          msg: "Anda harus menyertakan setidaknya 1 foto!",
          toastLength: Toast.LENGTH_LONG);
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
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ClipPath(
                clipper: CurvedBottomClipper(),
                child: Container(
                  color: Colors.lightGreen,
                  height: 250.0,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Text(
                        "Bagikan ceritamu",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).size.height / 4, 8, 8),
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
                    (_isUploading == false)
                        ? ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () {
                              final dt = StoriesItem(
                                  cityId: widget.idCity,
                                  locationId: widget.idContext,
                                  judulCerita: _judulCerita.text.toString(),
                                  isiCerita: _isiCerita.text.toString(),
                                  image: _arrImageUrl,
                                  owner: FirebaseAuth.instance.currentUser!.uid,
                                  category: widget.konteks);
                              uploadFunction(_selectedFiles, dt);
                            },
                          )
                        : const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator()),
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

class CurvedBottomClipper extends CustomClipper<Path> {
  var pi = 22 / 7;
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 3 / 8;

    // this is top part of path, rectangle without any rounding
    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    // this is rectangle that will be used to draw arc
    // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
    // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
    final roundingRectangle = Rect.fromLTRB(
        -5, size.height - roundingHeight * 2, size.width + 5, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    // so as I wrote before: arc is drawn from center of roundingRectangle
    // 2nd and 3rd arguments are angles from center to arc start and end points
    // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
