import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zipcode/Models/ZipModel.dart';
import 'package:http/http.dart' as http;

class MyZipCodeApi extends StatefulWidget {
  final String tzipCode;
 const MyZipCodeApi({Key? key, required this.tzipCode}) : super(key: key);
  @override
  State<MyZipCodeApi> createState() => _MyZipCodeApiState();
}

class _MyZipCodeApiState extends State<MyZipCodeApi> {
  ZipCode? details;
  List<Places>? ofplaces;

  var BaseUri = "https://api.zippopotam.us/in/";

  void GetPlaces() async {
    
    try {
      var placeApi = await http.get(Uri.parse(BaseUri + widget.tzipCode));

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
  void initState() {
    GetPlaces();
    super.initState();
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
          
        ],
      ),
    );
  }
}
