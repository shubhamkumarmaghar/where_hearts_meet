class UserModel {
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

  UserModel(
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
        this.userCreatedViaGuest});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['date_of_birth'] = dateOfBirth;
    data['address'] = address;
    data['phone_number'] = phoneNumber;
    data['gender'] = gender;
    data['marital_status'] = maritalStatus;
    data['profile_pic'] = profilePic;
    data['email'] = email;
    return data;
  }
}

