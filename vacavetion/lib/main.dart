import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';




const String hiveBox = 'dataStorage';

Future main() async {
  await Hive.initFlutter();
  await Hive.openBox(hiveBox);
  final box = Hive.box(hiveBox);

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

  Widget build(BuildContext context) {

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: const Text("He'd have you all unravel at the"),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Heed not the rabble'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Who scream'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Revolution is coming...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Revolution, they...'),
        ),
      ],
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
          child: Column(
              children: [
                ]
          )
      ),
    );

  }
}

