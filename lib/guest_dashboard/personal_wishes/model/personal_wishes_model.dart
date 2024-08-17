
class PersonalWishesCoverModel {
  int? id;
  String? eventId;
  String? message;
  String? coverImage;

  PersonalWishesCoverModel({this.id, this.eventId, this.message, this.coverImage});

  PersonalWishesCoverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    message = json['message'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_id'] = this.eventId;
    data['message'] = this.message;
    data['cover_image'] = this.coverImage;
    return data;
  }
}