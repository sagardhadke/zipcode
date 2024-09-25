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
  bool isLoading = true; // Track loading state
  String errorMessage = ''; // Store error messages

  var BaseUri =
      "https://api.zippopotam.us/in/"; // Replace with your actual API URL

  void GetPlaces() async {
    try {
      final response = await http.get(Uri.parse(BaseUri + widget.tzipCode));

      if (response.statusCode == 200) {
        details = ZipCode.fromJson(jsonDecode(response.body));
        ofplaces = details!.places;

        // Check if places list is empty
        if (ofplaces == null || ofplaces!.isEmpty) {
          errorMessage = "No places found.";
        }
      } else {
        errorMessage = "Error: Data Not Found";
      }
    } catch (e) {
      errorMessage = "Failed to fetch data: ${e.toString()}";
    } finally {
      setState(() {
        isLoading = false; // Stop loading when done
      });
    }
  }

  @override
  void initState() {
    super.initState();
    GetPlaces(); // Fetch places data on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "ZipCode Info",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator.adaptive() // Show loading indicator
            : errorMessage.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 150,
                        'assets/location.png',
                      ),
                      SizedBox(height: 20),
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: ofplaces!.length,
                    itemBuilder: (context, i) {
                      Places data = ofplaces![i];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          color: const Color(0xFFF5F4F4),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Place Name: ${data.placeName ?? 'Data Not Available'}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "Longitude: ${data.longitude ?? 'Data Not Available'}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "Latitude: ${data.latitude ?? 'Data Not Available'}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "State: ${data.state ?? 'Data Not Available'}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "State Code: ${data.stateAbbreviation ?? 'Data Not Available'}"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
