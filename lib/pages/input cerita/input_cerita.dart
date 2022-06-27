// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/model/hotelData.dart';
import 'package:flutter_wisata/services/apiservices.dart';
import 'package:flutter_wisata/services/dbservices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class InputCerita extends StatefulWidget {
  final String konteks;
  const InputCerita({
    Key? key,
    required this.konteks,
  }) : super(key: key);

  @override
  State<InputCerita> createState() => _InputCeritaState();
}

class _InputCeritaState extends State<InputCerita> {
  final _judulCerita = TextEditingController();
  final _isiCerita = TextEditingController();
  final _namaTempat = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _judulCerita.dispose();
    _isiCerita.dispose();
    _namaTempat.dispose();
    super.dispose();
  }

  DestinationApiService destApi = DestinationApiService();
  late Future<List<DestinationAttractionData>> places;

  hotelService hotelApi = hotelService();
  late Future<List<listHotel>> hotels;

  late String idCity;
  late String idLocation;

  List<String> suggestions = [];

  bool isShow = false;
  bool isLoading = false;

  void submit() async {
    setState(() {
      isShow = false;
      isLoading = true;
    });

    //services

    if (widget.konteks == "attraction") {
      idCity = await destApi.getLocId(_namaTempat.text.toString());
      places = destApi.getAttractionData(idCity);
      places.whenComplete(() {
        convertFutureToList();
      });
    } else if (widget.konteks == "hotel") {
      idCity = "none";
      hotels = hotelApi.getDestinationID(_namaTempat.text.toString());
      hotels.whenComplete(() {
        convertFutureToList();
      });
    }
  }

  late List<listHotel> lclHotels;
  late List<DestinationAttractionData> lclAttractions;

  void convertFutureToList() async {
    suggestions.clear();
    if (widget.konteks == "hotel") {
      lclHotels = await hotels;
      for (var hotel in lclHotels) {
        suggestions.add(hotel.hotelName.toString());
      }
      setState(() {
        isShow = true;
        isLoading = false;
      });
    } else {
      lclAttractions = await places;
      for (var attraction in lclAttractions) {
        suggestions.add(attraction.cnama.toString());
      }
      setState(() {
        isShow = true;
        isLoading = false;
      });
    }
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  List<String> _arrImageUrl = [];

  int uploadItem = 0;
  bool _isUploading = false;

  void uploadFunction(List<XFile> _images, StoriesItem dt) async {
    //db
    if (dt.judulCerita != "" && dt.isiCerita != "") {
      if (idLocation != null || idLocation != "") {
        if (_images.isNotEmpty) {
          setState(() {
            _isUploading = true;
          });
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
        } else {
          Fluttertoast.showToast(
              msg: "Anda harus menyertakan setidaknya 1 foto!",
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        Fluttertoast.showToast(
            msg:
                "Gagal Menambahkan cerita. Harap pilih hotel / tempat wisata dahulu.",
            toastLength: Toast.LENGTH_LONG);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Gagal Menambahkan cerita. Harap lengkapi data",
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
          child: Container(
            child: Stack(
              children: [
                // ClipPath(
                //   clipper: CurvedBottomClipper(),
                //   child: Container(
                //     color: Colors.lightGreen,
                //     height: 250.0,
                //     child: Center(
                //       child: Padding(
                //         padding: EdgeInsets.only(bottom: 50),
                //         child: Text(
                //           "Bagikan ceritamu",
                //           style: TextStyle(
                //             fontSize: 25,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Write your review",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 10,),
                      Container(
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(30),
                          shadowColor: Color(0x55434343),
                          child: TextField(
                            controller: _namaTempat,
                            decoration: InputDecoration(
                                hintText: "Enter city/country name",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                suffixIcon: (isLoading == true)
                                    ? IconButton(
                                        onPressed: null,
                                        icon: CircularProgressIndicator(),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          submit();
                                        },
                                        icon: Icon(Icons.arrow_forward_ios),
                                      )),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Current Location: " + _namaTempat.text.toString()),
                      ),
                      
                      Form(
                        key: _formKey,
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: TypeAheadFormField(
                            suggestionsCallback: (pattern) => suggestions.where(
                              (item) => item
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()),
                            ),
                            itemBuilder: (_, String item) => ListTile(
                              title: Text(item),
                            ),
                            onSuggestionSelected: (String val) {
                              _textEditingController.text = val;
                              //search id location from class

                              if (widget.konteks == "attraction") {
                                for (var attraction in lclAttractions) {
                                  if (attraction.cnama == val) {
                                    idLocation = attraction.cid.toString();
                                    break;
                                  }
                                }
                              } else {
                                for (var hotel in lclHotels) {
                                  if (hotel.hotelName == val) {
                                    idLocation = hotel.id.toString();
                                    break;
                                  }
                                }
                              }

                              // var found = lclHotels.any((e) => e.hotelName == val);
                              // print("Aaaa -===== $found");
                            },
                            getImmediateSuggestions: true,
                            hideSuggestionsOnKeyboardHide: false,
                            hideOnEmpty: false,
                            noItemsFoundBuilder: (context) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('No item found!'),
                            ),
                            textFieldConfiguration: TextFieldConfiguration(
                              decoration: InputDecoration(
                                  hintText: 'Which place do you want to review',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.arrow_downward)),
                              controller: _textEditingController,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
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
                        child: const Text("Add some photos"),
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
                      // (_isUploading == false)
                      //     ? ElevatedButton(
                      //         child: const Text('Submit'),
                      //         onPressed: () {
                      //           final dt = StoriesItem(
                      //               cityId: idCity,
                      //               locationId: idLocation,
                      //               judulCerita: _judulCerita.text.toString(),
                      //               isiCerita: _isiCerita.text.toString(),
                      //               image: _arrImageUrl,
                      //               owner:
                      //                   FirebaseAuth.instance.currentUser!.uid,
                      //               category: widget.konteks);
                      //           uploadFunction(_selectedFiles, dt);
                      //         },
                      //       )
                      //     : const SizedBox(
                      //         width: 15,
                      //         height: 15,
                      //         child: CircularProgressIndicator()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: 
        (_isUploading == false)?
        FloatingActionButton.extended(
        onPressed: () {
          final dt = StoriesItem(
                                    cityId: idCity,
                                    locationId: idLocation,
                                    judulCerita: _judulCerita.text.toString(),
                                    isiCerita: _isiCerita.text.toString(),
                                    image: _arrImageUrl,
                                    owner:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    category: widget.konteks);
                                uploadFunction(_selectedFiles, dt);
        },
        label: const Text('Submit Review'),
        icon: const Icon(Icons.exit_to_app),
        backgroundColor: Colors.pink,
      ):const SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator()),
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
