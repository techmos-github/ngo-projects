class UserProfile {
  final String id;
  final String firstname;
  final String lastname;
  final String userrole;
  final String gender;
  final String age;
  final String bloodgroup;
  final String email;
  final String password;
  final String mobileno;
  final String district;
  final String location;
  final bool isactive;
  final bool isdeleted;
  final String lastdonateddate;


  const UserProfile({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.age,
    required this.userrole,
    required this.bloodgroup,
    required this.email,
    required this.password,
    required this.mobileno,
    required this.district,
    required this.location,
    required this.isactive,
    required this.isdeleted,
    required this.lastdonateddate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      gender: json['gender'] as String,
      age: json['age'] as String,
      userrole: json['userrole'] as String,
      bloodgroup: json['bloodgroup'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      mobileno: json['mobileno'] as String,
      district: json['district'] as String,
      location: json['location'] as String,
      isactive: json['isactive'] as bool,
      isdeleted: json['isdeleted'] as bool,
      lastdonateddate: json['lastdonateddate'] as String,
    );
  }
}