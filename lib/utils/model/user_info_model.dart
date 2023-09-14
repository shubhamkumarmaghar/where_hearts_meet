class UserInfoModel {
  String? imageUrl;
  String? name;
  int? age;
  int? id;

  UserInfoModel({this.imageUrl, this.name, this.age, this.id});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    name = json['name'];
    age = json['age'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['age'] = age;
    data['id'] = id;
    return data;
  }
}