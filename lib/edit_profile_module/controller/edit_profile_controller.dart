import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../utils/model/dropdown_model.dart';

class EditProfileController extends BaseController {
  final nameTextController = TextEditingController();
  final birthDateTextController = TextEditingController();
  RxnString errorNameText = RxnString(null);
  Rx<String> relationValue = '0'.obs;
  Rx<String> dateOfBirth = 'Select date of birth'.obs;

  void onNameChanged(String name) {
    if (GetUtils.isAlphabetOnly(name)) {
      errorNameText.value = null;
    } else {
      errorNameText.value = 'Enter valid name';
    }
  }

  List<DropDownModel> getRelationDropdownList() {
    List<DropDownModel> list = [];
    list.add(DropDownModel(title: 'None', value: '0'));
   // list.add(DropDownModel(title: 'Father', value: '1'));
   // list.add(DropDownModel(title: 'Mother', value: '2'));
   // list.add(DropDownModel(title: 'Brother', value: '3'));
   // list.add(DropDownModel(title: 'Sister', value: '4'));
    list.add(DropDownModel(title: 'Friend', value: '5'));
    list.add(DropDownModel(title: 'Girl-friend', value: '6'));
    list.add(DropDownModel(title: 'boy-friend', value: '7'));
    list.add(DropDownModel(title: 'Wife', value: '8'));
    list.add(DropDownModel(title: 'Not-Specified', value: '9'));
    return list;
  }

  @override
  void onClose() {
    nameTextController.dispose();
    birthDateTextController.dispose();
    super.onClose();
  }
}
