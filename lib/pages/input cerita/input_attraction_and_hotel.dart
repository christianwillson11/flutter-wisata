// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/model/hotelData.dart';
import 'package:flutter_wisata/pages/input%20cerita/input_cerita.dart';
import 'package:flutter_wisata/services/apiservices.dart';

//input attraction
class InputSelector extends StatefulWidget {
  final String type;
  const InputSelector({Key? key, required this.type}) : super(key: key);

  @override
  State<InputSelector> createState() => _InputSelectorState();
}

class _InputSelectorState extends State<InputSelector> {
  final _namaTempat = TextEditingController();

  @override
  void dispose() {
    _namaTempat.dispose();
    super.dispose();
  }

  DestinationApiService destApi = DestinationApiService();
  late Future<List<DestinationAttractionData>> places;

  hotelService hotelApi = hotelService();
  late Future<List<listHotel>> hotels;

  late String idCity;

  bool isShow = false;
  bool isLoading = false;

  void submit() async {
    setState(() {
      isShow = false;
      isLoading = true;
    });

    //services

    if (widget.type == "attraction") {
      try {
        idCity = await destApi.getLocId(_namaTempat.text.toString());
        places = destApi.getAttractionData(idCity);
        places.whenComplete(() {
          setState(() {
            isShow = true;
            isLoading = false;
          });
        });
      } on Exception catch (ex) {
        final snackBar = SnackBar(content: Text(ex.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else if (widget.type == "hotel") {
      hotels = hotelApi.getDestinationID(_namaTempat.text.toString());
      hotels.whenComplete(() {
        setState(() {
          isShow = true;
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Input ${widget.type}"),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              const Text(
                "Sebelumnya, pilih kota dulu yuk...",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
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
                        hintText: "Masukkan nama kota",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: (isLoading == true)
                            ? IconButton(
                                onPressed: null,
                                icon: Icon(Icons.arrow_forward_ios),
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
              // ElevatedButton(
              //   onPressed: () {
              //     submit();
              //   },
              //   child: const Text("Cari"),
              // ),
              Expanded(
                child: data(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget data() {
    if (isShow == true && isLoading == false) {
      return Container(
        padding: const EdgeInsets.all(5.0),
        child: (widget.type == "attraction")
            ? FutureBuilder<List<DestinationAttractionData>>(
                future: places,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    List<DestinationAttractionData> isiData = snapshot.data!;
                    return ListView.builder(
                      itemCount: isiData.length - 1,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text("${isiData[index].cnama}"),
                            subtitle: Text("${isiData[index].cdescription}"),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return InputCerita(
                                        idCity: idCity,
                                        idContext: isiData[index].cid!,
                                        konteks: widget.type);
                                  },
                                ),
                              );
                            },
                          ),
                        );
                        // return
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              )
            : FutureBuilder<List<listHotel>>(
                future: hotels,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    List<listHotel> isiData = snapshot.data!;
                    return ListView.builder(
                      itemCount: isiData.length - 1,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text("${isiData[index].hotelName}"),
                            subtitle: Text("${isiData[index].alamat}"),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return InputCerita(
                                        idCity: 'none',
                                        idContext: isiData[index].id!,
                                        konteks: widget.type);
                                  },
                                ),
                              );
                            },
                          ),
                        );
                        // return
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              ),
      );
    } else if (isLoading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Text("...");
    }
  }
}
