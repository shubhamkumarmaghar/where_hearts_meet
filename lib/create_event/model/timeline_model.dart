class TimelineModel {
  List<String>? images;
  List<String>? videos;
  String? eventId;
  String? id;

  TimelineModel({images, videos, eventId, id});

  TimelineModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    eventId = json['event_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    data['images'] = images;
    data['videos'] = videos;
    data['event_id'] = eventId;
    return data;
  }
}