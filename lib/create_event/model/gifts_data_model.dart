class GiftsDataModel {
  int? id;
  String? title;
  String? code;
  String? image;

  GiftsDataModel({id, title, code, image});

  GiftsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['image'] = image;
    return data;
  }
}