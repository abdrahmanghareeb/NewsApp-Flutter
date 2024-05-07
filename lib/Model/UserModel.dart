class UserModel{
  String email = "";
  String uid = "";
  String? username = "";
  String? phone = "";
  String? photo = "";
  String? job_description = "";
  String? job_title = "";

  UserModel(
      {required this.uid, required this.email, this.username, this.phone, this.job_description, this.job_title, this.photo});

  factory UserModel.fromJson(Map<String, dynamic>? json){
    return UserModel(
      uid: json?["uid"], email: json?["email"],
      username:  json?["username"],
      job_description:  json?["job_description"],
      job_title:  json?["job_title"],
      phone:  json?["phone"],
      photo:  json?["photo"],);
  }

  Map<String , dynamic> toMap()
  { return {
    "email" : email,
    "uid" : uid,
    "username" : username,
    "phone" : phone,
    "photo" : photo,
    "job_description" : job_description,
    "job_title" : job_title,
  };
  }

}