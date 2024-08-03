class GiftsCard {
  int? id;
  String? title;
  String? code;
  String? image;

  GiftsCard({id, title, code, image});

  GiftsCard.fromJson(Map<String, dynamic> json) {
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