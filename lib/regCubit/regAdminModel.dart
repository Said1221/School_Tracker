class regAdminModel{
  late String name;
  late String email;
  late String phone;
  late double latitude;
  late double longitude;
  late String UID;

  regAdminModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.UID,
});

  // regAdminModel.fromJson(Map<String,dynamic>json){
  //   name = json['name'];
  //   email = json['email'];
  //   phone = json['phone'];
  // }

  Map<String , dynamic>toMap(){
    return{
      'name' : name,
      'email' : email,
      'phone' : phone,
      'latitude' : latitude,
      'longtude' : longitude,
      'UID' : UID,
    };
  }

}