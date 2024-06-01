class EventDetailsModel {
  int? id;
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
  List<ImageUrls>? imageUrls;

  EventDetailsModel(
      {this.id,
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
        this.imageUrls});

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    if (json['image_urls'] != null) {
      imageUrls = <ImageUrls>[];
      json['image_urls'].forEach((v) {
        imageUrls!.add(new ImageUrls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    if (this.imageUrls != null) {
      data['image_urls'] = this.imageUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageUrls {
  String? imageId;
  String? imageUrl;

  ImageUrls({this.imageId, this.imageUrl});

  ImageUrls.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['image_url'] = this.imageUrl;
    return data;
  }
}