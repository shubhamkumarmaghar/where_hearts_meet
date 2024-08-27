class PersonalDecorationsModel {
  String? eventId;
  List<String>? images;
  List<String>? videos;
  int? id;

  PersonalDecorationsModel({this.eventId, this.images, this.videos, this.id});

  PersonalDecorationsModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['images'] = images;
    data['videos'] = videos;
    return data;
  }
}