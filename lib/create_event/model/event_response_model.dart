class EventResponseModel {
  String? eventName;
  String? hostName;
  String? eventType;
  String? eventHostDay;
  String? eventSubtext;
  String? eventDescription;
  String? eventid;
  String? receiverPhoneNumber;
  String? username;
  String? receiverName;
  bool? globalEvent;
  String? coverImage;
  String? splashBackgroundImage;
  String? splashDisplayImage;

  EventResponseModel(
      {
        this.eventName,
        this.hostName,
        this.eventType,
        this.eventHostDay,
        this.eventSubtext,
        this.eventDescription,
        this.eventid,
        this.receiverPhoneNumber,
        this.username,
        this.receiverName,
        this.globalEvent,
        this.coverImage,
        this.splashBackgroundImage,
        this.splashDisplayImage});

  EventResponseModel.fromJson(Map<String, dynamic> json) {

    eventName = json['event_name'];
    hostName = json['host_name'];
    eventType = json['event_type'];
    eventHostDay = json['event_date'];
    eventSubtext = json['event_subtext'];
    eventDescription = json['event_description'];
    eventid = json['eventid'];
    receiverPhoneNumber = json['receiver_phone_number'];
    username = json['username'];
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
    data['event_subtext'] = this.eventSubtext;
    data['event_description'] = this.eventDescription;
    data['eventid'] = this.eventid;
    data['receiver_phone_number'] = this.receiverPhoneNumber;
    data['username'] = this.username;
    data['receiver_name'] = this.receiverName;
    data['global_event'] = this.globalEvent;
    data['cover_image'] = this.coverImage;
    data['splash_background_image'] = this.splashBackgroundImage;
    data['splash_display_image'] = this.splashDisplayImage;
    return data;
  }
}