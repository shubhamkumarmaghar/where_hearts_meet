class TimeLineModel {
  String? message;
  List<Data>? data;

  TimeLineModel({this.message, this.data});

  TimeLineModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? eventId;
  int? id;
  List<String>? images;
  List<String>? videos;

  Data({this.eventId, this.id, this.images, this.videos});

  Data.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    id = json['id'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
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