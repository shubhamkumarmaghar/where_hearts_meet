class PeopleModel {
  String? imageUrl;
  String? name;

  PeopleModel({this.imageUrl, this.name});

  PeopleModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['name'] = name;
    return data;
  }
}