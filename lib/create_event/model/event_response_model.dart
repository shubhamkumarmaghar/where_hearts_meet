class EventResponseModel {
  int? id;
  String? eventName;
  String? hostName;
  String? eventType;
  String? eventHostDay;
  String? eventDescription;
  String? eventid;
  String? receiverPhoneNumber;
  String? receiverName;
  bool? globalEvent;
  String? coverImage;
  String? splashBackgroundImage;
  bool? deletedForHost;
  bool? deletedForReceiver;
  bool? hasWishes;
  bool? hasPersonalWishes;
  bool? hasGifts;

  EventResponseModel(
      {this.id,
        this.eventName,
        this.hostName,
        this.eventType,
        this.eventHostDay,
        this.eventDescription,
        this.eventid,
        this.receiverPhoneNumber,
        this.receiverName,
        this.globalEvent,
        this.coverImage,
        this.splashBackgroundImage,
        this.deletedForHost,
        this.deletedForReceiver,
        this.hasWishes,
        this.hasPersonalWishes,
        this.hasGifts});

  EventResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    hostName = json['host_name'];
    eventType = json['event_type'];
    eventHostDay = json['event_host_day'];
    eventDescription = json['event_description'];
    eventid = json['eventid'];
    receiverPhoneNumber = json['receiver_phone_number'];
    receiverName = json['receiver_name'];
    globalEvent = json['global_event'];
    coverImage = json['cover_image'];
    splashBackgroundImage = json['splash_background_image'];
    deletedForHost = json['deleted_for_host'];
    deletedForReceiver = json['deleted_for_receiver'];
    hasWishes = json['has_wishes'];
    hasPersonalWishes = json['has_personal_wishes'];
    hasGifts = json['has_gifts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['host_name'] = this.hostName;
    data['event_type'] = this.eventType;
    data['event_host_day'] = this.eventHostDay;
    data['event_description'] = this.eventDescription;
    data['eventid'] = this.eventid;
    data['receiver_phone_number'] = this.receiverPhoneNumber;
    data['receiver_name'] = this.receiverName;
    data['global_event'] = this.globalEvent;
    data['cover_image'] = this.coverImage;
    data['splash_background_image'] = this.splashBackgroundImage;
    data['deleted_for_host'] = this.deletedForHost;
    data['deleted_for_receiver'] = this.deletedForReceiver;
    data['has_wishes'] = this.hasWishes;
    data['has_personal_wishes'] = this.hasPersonalWishes;
    data['has_gifts'] = this.hasGifts;
    return data;
  }
}