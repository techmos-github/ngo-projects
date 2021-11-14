class Location {
  final String id;
  final String district;
  final List<dynamic> location;
  final String state;
  final String country;

  const Location({
    required this.id,
    required this.district,
    required this.location,
    required this.state,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as String,
      district: json['district'] as String,
      location: json['location'] as List<dynamic>,
      state: json['state'] as String,
      country: json['country'] as String,
    );
  }
}