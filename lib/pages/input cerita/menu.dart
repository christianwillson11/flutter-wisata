import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/input%20cerita/input_cerita.dart';
import 'package:flutter_wisata/pages/input%20cerita/input_kota.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<String> images = ["pagi.png", "tourist.png", "pagi.png"];
  List<String> title = ["Hotels", "Attractions", "Restaurant"];
  List<String> subTitle = ["Ayo Input Ceritamu"];
  List<String> description = ["Masukkan cerita serumu"];
  List<String> description2 = [
    "Tentang pengalamanmu menginap di hotel",
    "Tentang pengalamanmu berwisata",
    "Tentang testimoni restoran"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "What to Input?",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: title.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            if (index == 0) {
                              return InputKota();
                            } else if (index == 1) {
                              return InputKota();
                            } else {
                              return InputCerita(idContext: "x", context: "x");
                            }
                            
                          },
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Ink.image(
                              height: 200,
                              image:
                                  AssetImage("assets/images/${images[index]}"),
                              fit: BoxFit.fitWidth,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                title[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                                child: Text(
                                  subTitle[0],
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Text(description[0]),
                              Text(description2[index]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
