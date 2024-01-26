class regParentsModel{
  late String name;
  late String email;
  late String schoolEmail;
  late String phone;
  late String location;
  late String UID;

  regParentsModel({
    required this.name,
    required this.email,
    required this.schoolEmail,
    required this.phone,
    required this.location,
    required this.UID,
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
      'location' : location,
      'UID' : UID,
    };
  }

}