import 'package:flutter/material.dart';

class MyZipCodeApi extends StatefulWidget {
  const MyZipCodeApi({super.key});

  @override
  State<MyZipCodeApi> createState() => _MyZipCodeApiState();
}

class _MyZipCodeApiState extends State<MyZipCodeApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ZipCode Info", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.amber,
      ),

      body: Column(
        children: [
          
        ],
      ),
    );
  }
}