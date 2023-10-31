class UserInfoModel {
  String? imageUrl;
  String? name;
  String? email;
  String? password;
  String? dateOfBirth;
  String? uid;

  UserInfoModel({this.imageUrl, this.name, this.dateOfBirth, this.uid,this.password,this.email});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    dateOfBirth = json['dateOfBirth'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['dateOfBirth'] = dateOfBirth ;
    data['uid'] = uid;
    return data;
  }
}