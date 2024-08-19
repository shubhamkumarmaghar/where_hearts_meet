class PersonalWishesModel {
  int? id;
  String? eventId;
  String? message;
  String? coverImage;

  PersonalWishesModel({this.id, this.eventId, this.message, this.coverImage});

  PersonalWishesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    message = json['message'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['message'] = message;
    data['cover_image'] = coverImage;
    return data;
  }
}
