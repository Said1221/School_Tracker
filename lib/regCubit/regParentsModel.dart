class regParentsModel{
  late String name;
  late String email;
  late String schoolEmail;
  late String phone;
  late double latitude;
  late double longitude;
  late String UID;
  late String token;

  regParentsModel({
    required this.name,
    required this.email,
    required this.schoolEmail,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.UID,
    required this.token,
  });

  // regModel.fromJson(Map<String,dynamic>json){
  //   name = json['name'];
  //   email = json['email'];
  //   phone = json['phone'];
  //   location = json['location'];
  //   UID = json['UID'];
  // }

  Map<String , dynamic>toMap(){
    return{
      'name' : name,
      'email' : email,
      'schoolEmail' : schoolEmail,
      'phone' : phone,
      'latitude' : latitude,
      'longitude' : longitude,
      'UID' : UID,
      'token' : token,
    };
  }

}