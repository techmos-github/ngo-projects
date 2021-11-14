class BloodRequest {
  final String id;
  final String patientname;
  final String age;
  final String requesttype;
  final String bloodgroup;
  final String units;
  final String location;
  final String status;

  const BloodRequest({
    required this.id,
    required this.patientname,
    required this.age,
    required this.bloodgroup,
    required this.units,
    required this.requesttype,
    required this.location,
    required this.status,
  });

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
      id: json['id'] as String,
      age: json['age'] as String,
      units: json['units'] as String,
      patientname: json['patientname'] as String,
      requesttype: json['requesttype'] as String,
      bloodgroup: json['bloodgroup'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
    );
  }
}