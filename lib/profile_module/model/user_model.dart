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
      {lastLogin,
        username,
        firstName,
        email,
        lastName,
        dateOfBirth,
        address,
        phoneNumber,
        gender,
        dateJoined,
        maritalStatus,
        isActive,
        profilePic,
        fcmToken,
        uid,
        isFirstTimeUser,
        userCreatedViaGuest});

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
    final Map<String, dynamic> data =  {};
    data['last_login'] = lastLogin;
    data['username'] = username;
    data['first_name'] = firstName;
    data['email'] = email;
    data['last_name'] = lastName;
    data['date_of_birth'] = dateOfBirth;
    data['address'] = address;
    data['phone_number'] = phoneNumber;
    data['gender'] = gender;
    data['date_joined'] = dateJoined;
    data['marital_status'] = maritalStatus;
    data['is_active'] = isActive;
    data['profile_pic'] = profilePic;
    data['fcm_token'] = fcmToken;
    data['uid'] = uid;
    data['is_first_time_user'] = isFirstTimeUser;
    data['user_created_via_guest'] = userCreatedViaGuest;
    return data;
  }
}