/*
class CreateEventResponseModel {
  String? message;
  Data? data;

  CreateEventResponseModel({this.message, this.data});

  CreateEventResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? eventName;
  String? hostName;
  String? eventType;
  String? eventHostDay;
  String? eventSubtext;
  String? eventDescription;
  String? eventid;
  String? phoneNumber;

  Data(
      {this.id,
        this.eventName,
        this.hostName,
        this.eventType,
        this.eventHostDay,
        this.eventSubtext,
        this.eventDescription,
        this.eventid,
        this.phoneNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    hostName = json['host_name'];
    eventType = json['event_type'];
    eventHostDay = json['event_host_day'];
    eventSubtext = json['event_subtext'];
    eventDescription = json['event_description'];
    eventid = json['eventid'];
    phoneNumber = json['phone_number'];
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
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}*/
