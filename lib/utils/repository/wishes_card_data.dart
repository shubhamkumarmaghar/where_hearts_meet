import 'package:where_hearts_meet/utils/consts/images_const.dart';

import '../model/dropdown_model.dart';

List<DropDownModel> getWishesCardsDataList() {
  return [
    DropDownModel(id: 2, title: 'Birthday', value: birthDayWishes),
    DropDownModel(id: 5, title: 'Anniversary', value: anniversaryWishes),
    DropDownModel(id: 3, title: 'Congratulations', value: congratulationWishes),
    DropDownModel(id: 6, title: 'Wedding', value: marriageWishes),
  ];
}
