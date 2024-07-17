class EventModel {
  String? eventName;
  String? hostName;
  String? eventType;
  String? eventHostDay;
  String? coverImage;
  String? receiverPhoneNumber;
  String? receiverName;
  bool? globalEvent;
  String? splashBackgroundImage;
  String? splashDisplayImage;

  EventModel({this.eventName,
    this.hostName,
    this.eventType,
    this.eventHostDay,
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
    coverImage = json['cover_image'];
    splashBackgroundImage = json['splash_background_image'];
    splashDisplayImage = json['splash_display_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['event_name'] = this.eventName;
    data['host_name'] = this.hostName;
    data['event_type'] = this.eventType;
    data['event_host_day'] = this.eventHostDay;
    data['receiver_phone_number'] = this.receiverPhoneNumber;
    data['receiver_name'] = this.receiverName;
    data['global_event'] = this.globalEvent;
    data['cover_image'] = this.coverImage;
    data['splash_background_image'] = this.splashBackgroundImage;
    data['splash_display_image'] = this.splashDisplayImage;
    return data;
  }
}