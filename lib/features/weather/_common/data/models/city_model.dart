import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  final List<City>? city;

  CityModel({
    this.city,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    city: List<City>.from(json["city"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "city": List<dynamic>.from(city?.map((x) => x.toJson()) ?? <City>[]),
  };
}

class City {
  String? cityId;
  String? countryId;
  String? regionId;
  String? name;

  City({
     this.cityId,
     this.countryId,
     this.regionId,
     this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    cityId: json["city_id"],
    countryId: json["country_id"],
    regionId: json["region_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "country_id": countryId,
    "region_id": regionId,
    "name": name,
  };
}
