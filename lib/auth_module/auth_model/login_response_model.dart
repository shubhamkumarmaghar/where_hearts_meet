class LoginResponseModel {
  String? message;
  Data? data;
  String? accessToken;

  LoginResponseModel({this.message, this.data, this.accessToken});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

class Data {
  int? id;
  dynamic lastLogin;
  bool? isSuperuser;
  String? username;
  bool? isStaff;
  String? email;
  String? firstName;
  String? lastName;
  dynamic dateOfBirth;
  String? address;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? phoneNumber;
  String? gender;
  String? dateJoined;
  String? maritalStatus;
  bool? isActive;
  String? profilePicUrl;

  Data({
    this.id,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.isStaff,
    this.email,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.phoneNumber,
    this.gender,
    this.dateJoined,
    this.maritalStatus,
    this.isActive,
    this.profilePicUrl,
    //this.groups,
    // this.userPermissions
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    isStaff = json['is_staff'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    dateJoined = json['date_joined'];
    maritalStatus = json['marital_status'];
    isActive = json['is_active'];
    profilePicUrl = json['profile_pic_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['last_login'] = this.lastLogin;
    data['is_superuser'] = this.isSuperuser;
    data['username'] = this.username;
    data['is_staff'] = this.isStaff;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['date_joined'] = this.dateJoined;
    data['marital_status'] = this.maritalStatus;
    data['is_active'] = this.isActive;
    data['profile_pic_url'] = this.profilePicUrl;

    return data;
  }
}
