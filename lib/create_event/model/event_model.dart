class EventModel {
  String? eventName;
  String? hostName;
  String? eventType;
  String? eventHostDay;
  String? coverImage;
  String? eventDescription;
  String? receiverPhoneNumber;
  String? receiverName;
  bool? globalEvent;
  String? splashBackgroundImage;
  String? splashDisplayImage;

  EventModel(
      {this.eventName,
      this.hostName,
      this.eventType,
      this.eventHostDay,
      this.eventDescription,
      this.receiverPhoneNumber,
      this.receiverName,
      this.coverImage,
      this.globalEvent,
      this.splashBackgroundImage,
      this.splashDisplayImage});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    hostName = json['host_name'];
    eventType = json['event_type'];
    eventHostDay = json['event_host_day'];
    receiverPhoneNumber = json['receiver_phone_number'];
    receiverName = json['receiver_name'];
    globalEvent = json['global_event'];
    eventDescription = json['event_description'];
    coverImage = json['cover_image'];
    splashBackgroundImage = json['splash_background_image'];
    splashDisplayImage = json['splash_display_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['event_name'] = eventName;
    data['host_name'] = hostName;
    data['event_type'] = eventType;
    data['event_host_day'] = eventHostDay;
    data['receiver_phone_number'] = receiverPhoneNumber;
    data['receiver_name'] = receiverName;
    data['event_description'] = eventDescription;
    data['global_event'] = globalEvent;
    data['cover_image'] = coverImage;
    data['splash_background_image'] = splashBackgroundImage;
    data['splash_display_image'] = splashDisplayImage;

    return data;
  }
}
