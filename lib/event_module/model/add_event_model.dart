class AddEventModel {
  String? imageUrl;
  String? name;
  String? eventId;
  String? eventName;
  String? text1;
  String? text2;
  String? text3;
  String? fromEmail;
  String? toEmail;

  AddEventModel(
      {this.imageUrl, this.eventName,this.name, this.text1, this.text2, this.text3, this.fromEmail, this.toEmail});

  AddEventModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    name = json['name'];
    text1 = json['text1'];
    text2 = json['text2'];
    eventName = json['event_name'];
    eventId = json['event_id'];
    text3 = json['text3'];
    fromEmail = json['fromEmail'];
    toEmail = json['toEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['event_name'] = eventName;
    data['event_id'] = eventId;
    data['text1'] = text1;
    data['text2'] = text2;
    data['text3'] = text3;
    data['fromEmail']=fromEmail;
    data['toEmail']=toEmail;

    return data;
  }
}
