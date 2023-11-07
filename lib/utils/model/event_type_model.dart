import 'package:flutter/material.dart';

class EventTypeModel{
  String? eventName;
  String? eventTypeId;
  IconData? eventIcon;

  EventTypeModel({this.eventName,this.eventTypeId,this.eventIcon});
}

List<EventTypeModel> getEventsTypeList(){
  return [
    EventTypeModel(eventName: 'Select Event',eventTypeId: '0',eventIcon: Icons.select_all),
    EventTypeModel(eventName: 'Birthday',eventTypeId: '1',eventIcon: Icons.celebration),
    EventTypeModel(eventName: 'Congratulation',eventTypeId: '2',eventIcon:Icons.content_paste),
    EventTypeModel(eventName: 'Proposal',eventTypeId: '3',eventIcon: Icons.ac_unit),
    EventTypeModel(eventName: 'Others',eventTypeId: '4',eventIcon: Icons.event),

  ];
}