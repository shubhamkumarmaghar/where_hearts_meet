class EventsListModel {
  String? eventid;
  String? eventName;
  String? eventDescription;
  List<ImageUrls>? imageUrls;
  String? receiverName;

  EventsListModel({this.eventid,
    this.eventName,
    this.eventDescription,
    this.imageUrls,
    this.receiverName});

  EventsListModel.fromJson(Map<String, dynamic> json) {
    eventid = json['eventid'];
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    if (json['image_urls'] != null) {
      imageUrls = <ImageUrls>[];
      json['image_urls'].forEach((v) {
        imageUrls!.add(new ImageUrls.fromJson(v));
      });
    }
    receiverName = json['receiver_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventid'] = this.eventid;
    data['event_name'] = this.eventName;
    data['event_description'] = this.eventDescription;
    if (this.imageUrls != null) {
      data['image_urls'] = this.imageUrls!.map((v) => v.toJson()).toList();
    }
    data['receiver_name'] = this.receiverName;
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
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['image_id'] = this.imageId;
      data['image_url'] = this.imageUrl;
      return data;
    }
  }
