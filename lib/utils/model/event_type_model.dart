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
    EventTypeModel(eventName: 'Others',eventTypeId: '1',eventIcon: Icons.event),
    EventTypeModel(eventName: 'Birthday',eventTypeId: '2',eventIcon: Icons.celebration),
    EventTypeModel(eventName: 'Congratulation',eventTypeId: '3',eventIcon:Icons.content_paste),
    EventTypeModel(eventName: 'Proposal',eventTypeId: '4',eventIcon: Icons.ac_unit),


  ];
}