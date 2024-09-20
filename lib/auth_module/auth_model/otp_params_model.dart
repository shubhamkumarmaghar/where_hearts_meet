import 'package:heart_e_homies/utils/consts/screen_const.dart';

class OtpParamsModel {
  final String verificationId;
  final String phoneNumber;
  final UserType userType;

  OtpParamsModel({required this.verificationId, required this.phoneNumber, required this.userType});
}
