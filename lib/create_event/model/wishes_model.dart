class WishesModel {
  String? eventId;
  int? id;
  String? senderName;
  String? senderProfileImage;
  String? senderMessage;
  List<String>? imageUrls;
  List<String>? videoUrls;

  WishesModel(
      {this.eventId,
        this.senderName,
        this.senderProfileImage,
        this.senderMessage,
        this.id,
        this.imageUrls,
        this.videoUrls});

  WishesModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    senderName = json['sender_name'];
    senderProfileImage = json['sender_profile_image'];
    senderMessage = json['sender_message'];
    id = json['id'];
    imageUrls = json['image_urls'].cast<String>();
    videoUrls = json['video_urls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['sender_name'] = this.senderName;
    data['sender_profile_image'] = this.senderProfileImage;
    data['sender_message'] = this.senderMessage;
    data['image_urls'] = this.imageUrls;
    data['video_urls'] = this.videoUrls;
    return data;
  }
}