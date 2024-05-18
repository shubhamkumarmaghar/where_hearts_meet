class GiftCardModel {
  String? id;
  String? giftCardName;
  String? giftCardId;
  String? giftCardPine;
  String? giftCardImage;
  String? message;

  GiftCardModel({giftCardName, giftCardId, giftCardPine, giftCardImage, message});

  GiftCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    giftCardName = json['giftCardName'];
    giftCardId = json['giftCardId'];
    giftCardPine = json['giftCardPine'];
    giftCardImage = json['giftCardImage'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['giftCardName'] = giftCardName;
    data['giftCardId'] = giftCardId;
    data['giftCardPine'] = giftCardPine;
    data['giftCardImage'] = giftCardImage;
    data['message'] = message;
    return data;
  }
}
