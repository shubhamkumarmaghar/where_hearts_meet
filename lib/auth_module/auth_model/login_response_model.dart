class LoginResponseModel {
  String? message;
  Data? data;

  LoginResponseModel({this.message, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? lastLogin;
  String? username;
  String? firstName;
  String? email;
  String? lastName;
  String? dateOfBirth;
  String? address;
  String? phoneNumber;
  String? gender;
  String? dateJoined;
  String? maritalStatus;
  bool? isActive;
  String? profilePic;
  String? fcmToken;
  String? uid;
  bool? isFirstTimeUser;
  bool? userCreatedViaGuest;
  String? accessToken;

  Data(
      {this.lastLogin,
        this.username,
        this.firstName,
        this.email,
        this.lastName,
        this.dateOfBirth,
        this.address,
        this.phoneNumber,
        this.gender,
        this.dateJoined,
        this.maritalStatus,
        this.isActive,
        this.profilePic,
        this.fcmToken,
        this.uid,
        this.isFirstTimeUser,
        this.userCreatedViaGuest,
        this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    lastLogin = json['last_login'];
    username = json['username'];
    firstName = json['first_name'];
    email = json['email'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    dateJoined = json['date_joined'];
    maritalStatus = json['marital_status'];
    isActive = json['is_active'];
    profilePic = json['profile_pic'];
    fcmToken = json['fcm_token'];
    uid = json['uid'];
    isFirstTimeUser = json['is_first_time_user'];
    userCreatedViaGuest = json['user_created_via_guest'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_login'] = this.lastLogin;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['last_name'] = this.lastName;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['date_joined'] = this.dateJoined;
    data['marital_status'] = this.maritalStatus;
    data['is_active'] = this.isActive;
    data['profile_pic'] = this.profilePic;
    data['fcm_token'] = this.fcmToken;
    data['uid'] = this.uid;
    data['is_first_time_user'] = this.isFirstTimeUser;
    data['user_created_via_guest'] = this.userCreatedViaGuest;
    data['access_token'] = this.accessToken;
    return data;
  }
}
