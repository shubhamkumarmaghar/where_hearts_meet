class EventInfoModel {
  String? imageUrl;
  String? eventName;
  int? id;

  EventInfoModel({this.imageUrl, this.eventName, this.id});

  EventInfoModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    eventName = json['event_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['event_name'] = eventName;
    data['id'] = id;
    return data;
  }
}