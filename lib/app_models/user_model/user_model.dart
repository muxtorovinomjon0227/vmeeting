class UserModel {
   int?  id;
   String? fullName;
   String? email;
   String? login;

  UserModel({this.id, this.fullName, this.email, this.login});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    login = json['login'];
  }
}