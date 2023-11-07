class AddEventModel {
  String? imageUrl;
  String? name;
  List<String>? imageList;
  String? eventId;
  String? eventName;
  String? eventType;
  String? title;
  String? subtitle;
  String? eventInfo;
  String? fromEmail;
  String? toEmail;

  AddEventModel(
      {this.imageUrl,
      this.eventName,
        this.eventType,
      this.name,
      this.title,
      this.subtitle,
      this.eventInfo,
      this.fromEmail,
      this.toEmail,
      this.imageList});

  AddEventModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    name = json['name'];
    title = json['title'];
    subtitle = json['subtitle'];
    eventName = json['event_name'];
    eventType = json['event_type'];
    eventId = json['event_id'];
    eventInfo = json['event_info'];
    if (json['image_list'] != null) {
      imageList = json['image_list'].cast<String>();
    }

    fromEmail = json['fromEmail'];
    toEmail = json['toEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['event_name'] = eventName;
    data['event_type'] = eventType;
    data['event_id'] = eventId;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image_list'] = imageList;
    data['event_info'] = eventInfo;
    data['fromEmail'] = fromEmail;
    data['toEmail'] = toEmail;

    return data;
  }
}
