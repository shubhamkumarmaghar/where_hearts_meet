class PersonalMemoriesModel {
  int? id;
  String? eventId;
  String? description;
  String? file;
  String? fileType;

  PersonalMemoriesModel({this.id, this.eventId, this.description, this.file, this.fileType});

  PersonalMemoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    description = json['description'];
    file = json['file'];
    fileType = json['file_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['description'] = description;
    data['file'] = file;
    data['file_type'] = fileType;
    return data;
  }
}
