import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zipcode/Models/ZipModel.dart';
import 'package:http/http.dart' as http;

class MyZipCodeApi extends StatefulWidget {
  const MyZipCodeApi({super.key});

  @override
  State<MyZipCodeApi> createState() => _MyZipCodeApiState();
}

class _MyZipCodeApiState extends State<MyZipCodeApi> {
  ZipCode? details;
  List<Places>? ofplaces;
  TextEditingController myzip = TextEditingController();
  var BaseUri = "https://api.zippopotam.us/in/";

  void GetPlaces() async {
    
    try {
      var placeApi = await http.get(Uri.parse(BaseUri + myzip.text));
      
      if (placeApi.statusCode == 200) {
        details = ZipCode.fromJson(jsonDecode(placeApi.body));
        ofplaces = details!.places;

        print(ofplaces![0].placeName);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ZipCode Info",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: myzip,
              decoration:
                  InputDecoration(filled: true, fillColor: Colors.white),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                GetPlaces();
              },
              child: Text("Fetch Data"))
        ],
      ),
    );
  }
}
