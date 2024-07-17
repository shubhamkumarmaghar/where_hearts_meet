class EventDetailsModel {
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
  List<String>? imageUrls;
  bool? globalEvent;
  String? coverPic;
  String? splashDisplayImage;
  String? splashBackgroundImage;



  EventDetailsModel(
      {this.eventName,
      this.hostName,
      this.eventType,
      this.eventHostDay,
      this.eventSubtext,
      this.eventDescription,
      this.eventid,
      this.receiverPhoneNumber,
      this.username,
      this.receiverName,
      this.imageUrls,
        this.globalEvent,
        this.coverPic,
        this.splashBackgroundImage,
        this.splashDisplayImage
      });

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    hostName = json['host_name'];
    eventType = json['event_type'];
    eventHostDay = json['event_host_day'];
    eventSubtext = json['event_subtext'];
    eventDescription = json['event_description'];
    eventid = json['eventid'];
    receiverPhoneNumber = json['receiver_phone_number'];
    username = json['username'];
    receiverName = json['receiver_name'];
    imageUrls = json['image_urls'].cast<String>();
    globalEvent = json['global_event'];
    coverPic=json['cover_image'];
    splashDisplayImage=json['splash_display_image'];
    splashBackgroundImage=json['splash_background_image'];


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
    data['image_urls'] = this.imageUrls;
    data['global_event'] = this.globalEvent;
    data['cover_image'] = this.coverPic;
    data['splash_background_image'] = this.splashBackgroundImage;
    data['splash_display_image'] = this.splashDisplayImage;

    return data;
  }
}


