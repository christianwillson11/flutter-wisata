// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/apiservices.dart';
import 'package:flutter_wisata/pages/weatherData.dart';

class pageWeather extends StatefulWidget {
  const pageWeather({Key? key}) : super(key: key);

  @override
  State<pageWeather> createState() => _pageWeatherState();
}

class _pageWeatherState extends State<pageWeather> {
  final _ctrCuaca = TextEditingController();
  service weather = service();
  late Future<Weather> data;

  @override
  void initState() {
    // TODO: implement initState
    data = weather.getWeatherData('Indonesia');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ctrCuaca.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Weather simpanData = snapshot.data! as Weather;
          return Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pagi.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: _ctrCuaca,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Masukkan Nama Kota',
                              prefixIcon: Icon(Icons.search_outlined)),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(4, 4, 12, 4),
                              child: Text(
                                "${simpanData.temp} °C",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(4, 4, 12, 4),
                              child: Text(
                                "Feels like ${simpanData.feels} °C",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(4, 4, 12, 4),
                              child: Text(
                                "${simpanData.cityName}",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 3,
                          color: Colors.black,
                        ),
                        Text(
                          "Additional Information",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Wind Speed : ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Text(
                                        "Pressure : ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${simpanData.wind}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Text(
                                        "${simpanData.pressure}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Humidity ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Text(
                                        "Visibility ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${simpanData.humidity}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        "${simpanData.visibility}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 3,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_ctrCuaca.text.isNotEmpty) {
                              setState(() {
                                data = weather.getWeatherData(_ctrCuaca.text);
                              });
                            }
                            if (_ctrCuaca.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Mohon memasukkan Nama Kota terlebih dahulu!'),
                                ),
                              );
                            }
                          },
                          child: Text("Get Weather", style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
