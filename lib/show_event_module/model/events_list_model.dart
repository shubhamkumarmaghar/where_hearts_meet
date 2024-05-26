class EventsListModel {
  String? eventid;
  String? eventName;
  String? eventDescription;
  List<String>? imageUrls;
  String? receiverName;

  EventsListModel(
      {this.eventid,
        this.eventName,
        this.eventDescription,
        this.imageUrls,
        this.receiverName});

  EventsListModel.fromJson(Map<String, dynamic> json) {
    eventid = json['eventid'];
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    imageUrls = json['image_urls'].cast<String>();
    receiverName = json['receiver_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventid'] = this.eventid;
    data['event_name'] = this.eventName;
    data['event_description'] = this.eventDescription;
    data['image_urls'] = this.imageUrls;
    data['receiver_name'] = this.receiverName;
    return data;
  }
}