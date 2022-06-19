import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/pages/input%20cerita/input_cerita.dart';
import 'package:flutter_wisata/services/apiservices.dart';

class InputAttraction extends StatefulWidget {
  const InputAttraction({Key? key}) : super(key: key);

  @override
  State<InputAttraction> createState() => _InputAttractionState();
}

class _InputAttractionState extends State<InputAttraction> {
  final _namaTempat = TextEditingController();

  @override
  void dispose() {
    _namaTempat.dispose();
    super.dispose();
  }

  DestinationApiService destApi = DestinationApiService();
  late Future<List<DestinationAttractionData>> places;
  late String idCity;
  
  bool isShow = false;

  void submit() async {

    setState(() {
      isShow = false;
    });

    //services
    try {
      idCity = await destApi.getLocId(_namaTempat.text.toString());
      places = destApi.getAttractionData(idCity);
    } on Exception catch (ex) {
      print("Query process error: $ex");
    }

    setState(() {
      isShow = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Input Attraction"),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              Text(
                "Sebelumnya, pilih kota dulu yuk...",
                style: TextStyle(
                  fontSize: 15,
                ),
                
              ),
              SizedBox(
                height: 20,
              ),
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
                    padding: EdgeInsets.all(5.0),
                    child: FutureBuilder<List<DestinationAttractionData>>(
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
                                          return InputCerita(idCity: idCity, idContext: isiData[index].cid, context: "attraction",);
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
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
