class ImageResponseModel {
  String? fileUrl;
  String? fileId;
  String? uploadTime;
  String? uploadedBy;
  String? fileType;
  String? fileExt;

  ImageResponseModel(
      {this.fileUrl,
        this.fileId,
        this.uploadTime,
        this.uploadedBy,
        this.fileType,
        this.fileExt});

  ImageResponseModel.fromJson(Map<String, dynamic> json) {
    fileUrl = json['file_url'];
    fileId = json['file_id'];
    uploadTime = json['upload_time'];
    uploadedBy = json['uploaded_by'];
    fileType = json['file_type'];
    fileExt = json['file_ext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_url'] = this.fileUrl;
    data['file_id'] = this.fileId;
    data['upload_time'] = this.uploadTime;
    data['uploaded_by'] = this.uploadedBy;
    data['file_type'] = this.fileType;
    data['file_ext'] = this.fileExt;
    return data;
  }
}