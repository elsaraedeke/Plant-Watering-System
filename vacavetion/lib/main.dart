import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'general_plant.dart';
import 'package:google_fonts/google_fonts.dart';




const String hiveBox = 'dataStorage';

Future main() async {
  await Hive.initFlutter();
  await Hive.openBox(hiveBox);
  final box = Hive.box(hiveBox);

  if (!box.containsKey("plants")) {
    box.put("plants", List<Map<String, dynamic>>);
  }

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: Main()));
}


class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}



class _MainState extends State<Main> {
  int currentPageIndex = 0;


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFEBAD),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: <Widget>[
          Home(),
          const Chart()
        ][currentPageIndex], // show only the selected page
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.data_array)),
            label: 'About',
          ),
        ],
      ),
    );
  }
}


class Home extends StatefulWidget {
  Home({super.key});

  @override State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final box = Hive.box(hiveBox);
  final TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, box, child) { return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Text("My Plants", style: GoogleFonts.acme(fontSize: 50)),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  if (box.get("plants") != null)
                    for (var p in List.from(box.get("plants")))
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content:
                              SizedBox(
                                height: 700,
                              child: Column(

                                children: [
                                  Icon(
                                    Icons.grass,
                                    color: Colors.green,
                                    size: 150.0,
                                  ),
                                  Text(p['name'],
                                  style: GoogleFonts.acme(fontSize: 50)),
                                  Text(p['percentMoisture'].toString() + "%",
                                      style: GoogleFonts.acme(fontSize: 30)),
                                  Text(p['lastWatered'].month.toString() + "/" + p['lastWatered'].day.toString()+ " " + p['lastWatered'].hour.toString() + ":" + p['lastWatered'].minute.toString(),
                                      style: GoogleFonts.acme(fontSize: 30)),
                                  ElevatedButton(
                                      onPressed: () {
                                        var listPlants = List.from(box.get("plants") ?? []);
                                        listPlants.removeWhere((plant) => plant['name'] == p['name']);
                                        box.put("plants", listPlants);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Delete", style: GoogleFonts.acme())
                                  )
                                ],
                              )
                              )
                            )
                          );
                        },

                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                              color: Color.fromRGBO(179, 235, 159, 100),
                              border: Border.all(
                              color: Color.fromRGBO(126, 182, 105, 100)
                            )
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.grass,
                                  color: Colors.green,
                                  size: 80.0,
                                ),
                                Text(p['name'], style: GoogleFonts.acme()),
                                Text(p['percentMoisture'].toString() + "%", style: GoogleFonts.acme()),
                                Text(p['lastWatered'].month.toString() + "/" + p['lastWatered'].day.toString()+ " " + p['lastWatered'].hour.toString() + ":" + p['lastWatered'].minute.toString(), style: GoogleFonts.acme())
                              ]
                          )
                      )
                      )
                ]
              )
            ),
            ElevatedButton(
                onPressed: () {
                  box.get("plants");
                  showDialog(
                    context: context,
                      builder: (context) => AlertDialog(  // CHANGE child: to builder: (context) =>
                        title: Text('Add Plant', style: GoogleFonts.acme()),
                        content: TextField(
                          controller: _controller,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'Enter plant name',
                          ),
                          onSubmitted: (value) {
                            print("\n\n\n ON SUBMITTED \n\n\n");
                            if(value.trim().isEmpty) return;
                            GeneralPlant p = GeneralPlant(value);
                            print("\n\n\n RUNNING \n\n\n");
                            var listPlants = box.get("plants");
                            print("\n\n\n RUNNING2 \n\n\n");
                            listPlants ??= <Map<String, dynamic>>[];
                            listPlants.add(p.createPlant());
                            box.put("plants", listPlants);
                            _controller.clear();
                            Navigator.pop(context);
                            print("\n\n\n CLOSED TEXT BOX \n\n\n");

                          },
                        ),
                      )
                  );
                },
                child: Icon(Icons.add),
            )
          ]
        )
        );
        }
    );

  }

}


class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
              children: [
                Text("About US",
                style: GoogleFonts.acme(fontSize: 50)),
                Text("We are a group of freshman coders who are passionate about making projects to solve problems!", style: GoogleFonts.acme(fontSize: 30)),
                Image.asset('assets/images/Kawaii_Dino_Invisi.png')
              ]
          )
      ),
    );

  }
}

