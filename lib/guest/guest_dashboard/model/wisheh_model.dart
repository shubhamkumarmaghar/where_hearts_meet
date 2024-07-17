class WishesModel {
  String? message;
  List<Data>? data;

  WishesModel({this.message, this.data});

  WishesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<String>? imageUrls;
  List<String>? videoUrls;
  String? senderName;
  String? senderProfileImage;
  String? senderMessage;
  int? id;

  Data(
      {this.imageUrls,
        this.videoUrls,
        this.senderName,
        this.senderProfileImage,
        this.senderMessage,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    imageUrls = json['image_urls'].cast<String>();
    videoUrls = json['video_urls'].cast<String>();

    senderName = json['sender_name'];
    senderProfileImage = json['sender_profile_image'];
    senderMessage = json['sender_message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_urls'] = this.imageUrls;
    data['video_urls'] = this.videoUrls;
    data['sender_name'] = this.senderName;
    data['sender_profile_image'] = this.senderProfileImage;
    data['sender_message'] = this.senderMessage;
    data['id'] = this.id;
    return data;
  }
}