class GiftModel {
  int? id;
  String? eventId;
  String? giftCode;
  String? giftTitle;
  String? giftLogo;
  String? senderName;
  String? cardId;
  String? cardPin;
  List<String>? giftImages;

  GiftModel({this.id, this.eventId, this.giftCode, this.giftTitle, this.senderName, this.cardId, this.cardPin, this.giftImages,this.giftLogo});

  GiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    giftCode = json['gift_code'];
    giftTitle = json['gift_title'];
    senderName = json['sender_name'];
    cardId = json['card_id'];
    giftLogo = json['gift_logo'];
    cardPin = json['card_pin'];
    giftImages = json['gift_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['gift_code'] = giftCode;
    data['gift_title'] = giftTitle;
    data['sender_name'] = senderName;
    data['card_id'] = cardId;
    data['gift_logo'] = giftLogo;
    data['card_pin'] = cardPin;
    data['gift_images'] = giftImages;
    return data;
  }
}
