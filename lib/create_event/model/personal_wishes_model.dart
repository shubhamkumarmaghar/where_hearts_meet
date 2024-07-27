class PersonalWishesModel {
  String? eventId;
  String? id;
  List<String>? personalWishes;
  List<String>? images;
  List<String>? videos;

  PersonalWishesModel({eventId, id, personalWishes, images, videos});

  PersonalWishesModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    id = json['id'];
    personalWishes = json['personal_wishes'] != null ? json['personal_wishes'].cast<String>() : [];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    videos = json['videos'] != null ? json['videos'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['personal_wishes'] = personalWishes;
    data['images'] = images;
    data['videos'] = videos;
    return data;
  }
}
