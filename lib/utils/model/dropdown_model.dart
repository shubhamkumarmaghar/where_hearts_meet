import 'package:flutter/cupertino.dart';

class DropDownModel {
  final int? id;
  final String title;
  final String? value;
  bool status;
  final Icon? icon;

  DropDownModel({this.id, required this.title, this.value, this.icon, this.status = false});
}
