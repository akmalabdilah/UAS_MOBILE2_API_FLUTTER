import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> stations = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://booking.kai.id/api/stations2'));

    if (response.statusCode == 200) {
      setState(() {
        stations = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Demo'),
        ),
        body: ListView.builder(
          itemCount: stations.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(stations[index]['name']),
              subtitle: Text(stations[index]['city']),
            );
          },
        ),
      ),
    );
  }
}
