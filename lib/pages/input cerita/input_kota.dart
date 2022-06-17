import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wisata/model/MPlace.dart';
import 'package:flutter_wisata/services/apiservices.dart';

class InputKota extends StatefulWidget {
  const InputKota({Key? key}) : super(key: key);

  @override
  State<InputKota> createState() => _InputKotaState();
}

class _InputKotaState extends State<InputKota> {
  final _namaTempat = TextEditingController();

  @override
  void dispose() {
    _namaTempat.dispose();
    super.dispose();
  }

  late Future<List<PlaceData>> places;

  bool isShow = false;

  void submit() {
    //services
    DestinationApiService destPlaceApi = DestinationApiService();
    places = destPlaceApi.getPlaceData(_namaTempat.text.toString());
    setState(() {
      isShow = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Input Kota"),
        ),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: _namaTempat,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.input),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: "Masukkan nama Kota",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  submit();
                },
                child: Text("Submit"),
              ),
              if (isShow == true)
                Expanded(
                  child: Container(
                    child: FutureBuilder<List<PlaceData>>(
                      future: places,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          List<PlaceData> isiData = snapshot.data!;
                          return ListView.builder(
                            itemCount: isiData.length,
                            itemBuilder: (context, index) {
                              return Text(
                                  "${isiData[index].cnama!} || ${isiData[index].cid}");
                            },
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
