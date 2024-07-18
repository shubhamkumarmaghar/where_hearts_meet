
class TimeLineModel {
  String? eventId;
  int? id;
  List<String>? images;
  List<String>? videos;

  TimeLineModel({this.eventId, this.id, this.images, this.videos});

  TimeLineModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    id = json['id'];
    images = json['images'] != null ? json['images'].cast<String>():[];
    videos = json['videos'] != null ?json['videos'].cast<String>():[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['id'] = this.id;
    data['images'] = this.images;
    data['videos'] = this.videos;
    return data;
  }
}