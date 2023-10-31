class PeopleModel {
  String? imageUrl;
  String? name;
  String? email;
  String? dateOfBirth;
  String? uid;

  PeopleModel({this.imageUrl, this.name, this.dateOfBirth, this.uid,this.email});

  PeopleModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    name = json['name'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['email'] = email;
    data['dateOfBirth'] = dateOfBirth ;
    data['uid'] = uid;
    return data;
  }
}