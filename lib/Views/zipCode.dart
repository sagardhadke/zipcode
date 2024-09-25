import 'package:flutter/material.dart';
import 'package:zipcode/Views/ZipCodeApi.dart';

class MyZipCode extends StatefulWidget {
  const MyZipCode({super.key});

  @override
  State<MyZipCode> createState() => _MyZipCodeState();
}

class _MyZipCodeState extends State<MyZipCode> {
  TextEditingController myzip = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

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
          Image.asset(height: 150, width: 150, "assets/location.png"),
          SizedBox(height: 5),
          Text(
            "Get information about a specified ZIP code.",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: myzip,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter Zip Code',
                    hintText: '400051',
                    prefixIcon: Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please Enter Zip Code";
                  } else if (value.length != 6 ||
                      !RegExp(r'^\d{6}$').hasMatch(value)) {
                    return 'Please enter a valid 6-digit ZIP code';
                  }
                  return null;
                },
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyZipCodeApi(tzipCode: myzip.text)));
                }
              },
              child: Text("Fetch Data"))
        ],
      ),
    );
  }
}
