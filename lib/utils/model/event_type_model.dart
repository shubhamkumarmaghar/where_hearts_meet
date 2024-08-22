import 'package:flutter/material.dart';

class EventTypeModel {
  String? eventName;
  String? eventTypeId;
  IconData? eventIcon;
  bool selected;

  EventTypeModel({this.eventName, this.eventTypeId, this.eventIcon, this.selected = false});
}

List<EventTypeModel> getEventsTypeList() {
  return [
    EventTypeModel(eventName: 'Birthday', eventTypeId: '2', eventIcon: Icons.celebration),
    EventTypeModel(eventName: 'Congratulation', eventTypeId: '3', eventIcon: Icons.content_paste),
    EventTypeModel(eventName: 'Proposal', eventTypeId: '4', eventIcon: Icons.ac_unit),
    EventTypeModel(eventName: 'Anniversary', eventTypeId: '5', eventIcon: Icons.ac_unit),
    EventTypeModel(eventName: 'Wedding', eventTypeId: '6', eventIcon: Icons.ac_unit),
    EventTypeModel(eventName: 'Others', eventTypeId: '1', eventIcon: Icons.event),
  ];
}
