
import 'dart:convert';

class ZipCode {
    String? postCode;
    String? country;
    String? countryAbbreviation;
    List<Places>? places;

    ZipCode({this.postCode, this.country, this.countryAbbreviation, this.places});

    ZipCode.fromJson(Map<String, dynamic> json) {
        postCode = json["post code"];
        country = json["country"];
        countryAbbreviation = json["country abbreviation"];
        places = json["places"] == null ? null : (json["places"] as List).map((e) => Places.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["post code"] = postCode;
        _data["country"] = country;
        _data["country abbreviation"] = countryAbbreviation;
        if(places != null) {
            _data["places"] = places?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Places {
    String? placeName;
    String? longitude;
    String? state;
    String? stateAbbreviation;
    String? latitude;

    Places({this.placeName, this.longitude, this.state, this.stateAbbreviation, this.latitude});

    Places.fromJson(Map<String, dynamic> json) {
        placeName = json["place name"];
        longitude = json["longitude"];
        state = json["state"];
        stateAbbreviation = json["state abbreviation"];
        latitude = json["latitude"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["place name"] = placeName;
        _data["longitude"] = longitude;
        _data["state"] = state;
        _data["state abbreviation"] = stateAbbreviation;
        _data["latitude"] = latitude;
        return _data;
    }

}