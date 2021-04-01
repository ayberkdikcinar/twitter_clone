class UserModel {
  String username;
  String photo;
  String profileurl;
  String id;
  String email;

  UserModel({this.username, this.photo, this.profileurl, this.id, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    photo = json['photo'];
    profileurl = json['profileurl'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['photo'] = this.photo;
    data['profileurl'] = this.profileurl;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}
