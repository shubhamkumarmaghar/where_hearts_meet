class PersonalWishesModel {
  String? eventId;
  int? id;
  List<String>? wishes;
  String? coverImage;
  List<String>? images;
  List<String>? videos;

  PersonalWishesModel({eventId, id, personalWishes, images, videos,coverImage});

  PersonalWishesModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    id = json['id'];
    coverImage = json['cover_image'];
    wishes = json['wishes'] != null ? json['wishes'].cast<String>() : [];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    videos = json['videos'] != null ? json['videos'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['wishes'] = wishes;
    data['images'] = images;
    data['cover_image'] = coverImage;
    data['videos'] = videos;
    return data;
  }
}
