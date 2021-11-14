class LocationModel {

  var data = <LocationList>[];
  LocationModel({ required this.data});

  LocationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LocationList>[];
      json['data'].forEach((v) {
        data.add(LocationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationList {
  String? district;
  List<Locations>? locations;

  LocationList({ this.district, this.locations});

  LocationList.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['district'] = this.district;
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  int? id;
  String? name;
  String? city;
  String? district;


  Locations({
    this.id,
    this.name,
    this.city,
    this.district,
  });

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['district'] = this.district;

    return data;
  }
}