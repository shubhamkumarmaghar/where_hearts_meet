class PersonalMessagesModel {
  int? id;
  String? eventId;
  List<String>? messages;
  String? image;
  String? textColor;

  PersonalMessagesModel(
      {this.id, this.eventId, this.messages, this.image, this.textColor});

  PersonalMessagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    messages = json['messages'].cast<String>();
    image = json['image'];
    textColor = json['text_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['id'] = this.id;
    data['event_id'] = eventId;
    data['messages'] = messages;
    data['image'] = image;
    data['text_color'] = textColor;
    return data;
  }
}