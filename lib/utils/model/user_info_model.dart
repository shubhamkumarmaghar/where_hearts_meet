class UserInfoModel {
  String? firstName;
  String? email;
  String? lastName;
  String? dateOfBirth;
  String? address;
  String? gender;
  String? maritalStatus;
  String? profilePic;

  UserInfoModel(
      {this.firstName,
        this.email,
        this.lastName,
        this.dateOfBirth,
        this.address,
        this.gender,
        this.maritalStatus,
        this.profilePic});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    email = json['email'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['last_name'] = this.lastName;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}