class BloodRequest {
  final String id;
  final String patientid;
  final String patientname;
  final String age;
  final String gender;
  final String requesttype;
  final String bloodgroup;
  final String units;
  final String medicalstatus;
  final String requeststatus;
  final String district;
  final String location;
  final String requestdate;
  final String duedate;
  final String approvedby;
  final String approveddate;

  const BloodRequest({
    required this.id,
    required this.patientid,
    required this.patientname,
    required this.age,
    required this.gender,
    required this.requesttype,
    required this.bloodgroup,
    required this.units,
    required this.medicalstatus,
    required this.requeststatus,
    required this.district,
    required this.location,
    required this.requestdate,
    required this.duedate,
    required this.approvedby,
    required this.approveddate,
  });

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
      id: json['id'] as String,
      patientid: json['patientid'] as String,
      patientname: json['patientname'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
      requesttype: json['requesttype'] as String,
      bloodgroup: json['bloodgroup'] as String,
      units: json['units'] as String,
      medicalstatus: json['medicalstatus'] as String,
      requeststatus: json['requeststatus'] as String,
      district: json['district'] as String,
      location: json['location'] as String,
      requestdate: json['requestdate'] as String,
      duedate: json['duedate'] as String,
      approvedby: json['approvedby'] as String,
      approveddate: json['approveddate'] as String,
    );
  }
}