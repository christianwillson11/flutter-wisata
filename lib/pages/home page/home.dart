import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MResep.dart';
import 'package:flutter_wisata/pages/home%20page/det_wisata.dart';

class Home extends StatefulWidget {
  final String index;
  const Home({Key? key, required this.index}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: MResep.isiResep.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ListWisata(postresep: MResep.isiResep[index]);
                  },
                ),
              );
            },
            child: resepCard(MResep.isiResep[index]),
          );
        },
      ),
    );
  }

  Widget resepCard(MResep resep) {
    return Card(
      child: Column(
        children: [
          Image.network(resep.gambarURL),
          const SizedBox(
            height: 10,
          ),
          Text(
            resep.namamenu,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

}
