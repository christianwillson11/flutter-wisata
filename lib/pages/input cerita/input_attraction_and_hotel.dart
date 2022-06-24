import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';
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
  late String idCity;
  
  bool isShow = false;

  void submit() async {

    setState(() {
      isShow = false;
    });

    //services

    if (widget.type == "attraction") {
      try {
        idCity = await destApi.getLocId(_namaTempat.text.toString());
        places = destApi.getAttractionData(idCity);
      } on Exception catch (ex) {
        print("Query process error: $ex");
      }
    } else if (widget.type == "hotel") {

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
                child: const Text("Cari"),
              ),
              if (isShow == true)
                Expanded(
                  child: Container(
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
                                          return InputCerita(idCity: idCity, idContext: isiData[index].cid!, konteks: widget.type);
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
                    : Text("ini hotel"),
                  
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
