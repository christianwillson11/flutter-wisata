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
  hotelService hotelApi = hotelService();

  String idCity = "";
  String idLocation = "";

  List<String> suggestions = [];

  bool isLoading = false;
  bool isError = false;

  void submit() async {
    setState(() {
      isLoading = true;
    });

    //services

    if (widget.konteks == "attraction") {
      try {
        idCity = await destApi.getLocId(_namaTempat.text.toString());
        giveSuggestions();
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } else if (widget.konteks == "hotel") {
      try {
        idCity = await hotelApi.getCityID(_namaTempat.text.toString());
        giveSuggestions();
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Failed to provide city ID", toastLength: Toast.LENGTH_LONG);
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    }
  }

  late List<listHotel> lclHotels;
  late List<DestinationAttractionData> lclAttractions;

  void giveSuggestions() async {
    suggestions.clear();
    if (widget.konteks == "hotel") {
      try {
        lclHotels =
            await hotelApi.getDestinationID(_namaTempat.text.toString());
        for (var hotel in lclHotels) {
          suggestions.add(hotel.hotelName.toString());
        }
        setState(() {
          isLoading = false;
          isError = false;
        });
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } else {
      try {
        lclAttractions = await destApi.getAttractionData(idCity);
        for (var attraction in lclAttractions) {
          suggestions.add(attraction.cnama.toString());
        }
        setState(() {
          isLoading = false;
          isError = false;
        });
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    }
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  List<String> _arrImageUrl = [];

  int uploadItem = 0;
  bool _isUploading = false;

  void uploadFunction(List<XFile> _images, StoriesItem dt) async {
    //db
    if (isError == false) {
      if (dt.judulCerita != "" && dt.isiCerita != "") {
        if (idLocation != "" && idCity != "") {
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
    } else {
      Fluttertoast.showToast(
          msg: "Please try again later", toastLength: Toast.LENGTH_LONG);
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
                    SizedBox(
                      height: 10,
                    ),
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
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                prefixIcon: Icon(Icons.location_pin),
                                suffixIcon: Icon(Icons.arrow_downward)),
                            controller: _textEditingController,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: (_isUploading == false)
            ? FloatingActionButton.extended(
                onPressed: () {
                  final dt = StoriesItem(
                      cityId: idCity,
                      locationId: idLocation,
                      judulCerita: _judulCerita.text.toString(),
                      isiCerita: _isiCerita.text.toString(),
                      image: _arrImageUrl,
                      owner: FirebaseAuth.instance.currentUser!.uid,
                      category: widget.konteks);
                  uploadFunction(_selectedFiles, dt);
                },
                label: const Text('Submit Review'),
                icon: const Icon(Icons.exit_to_app),
                backgroundColor: Colors.pink,
              )
            : const SizedBox(
                width: 15, height: 15, child: CircularProgressIndicator()),
      ),
    );
  }
}
