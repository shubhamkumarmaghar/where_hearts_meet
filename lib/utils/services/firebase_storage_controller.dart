import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

class FirebaseStorageController extends BaseController{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadPic({required File file}) async {
    User? user = auth.currentUser;
    final reference = _storage.ref("profilePics/").child("profile_pic_${user?.uid}");
    final uploading = await reference.putFile(file);
    return await reference.getDownloadURL();
  }
  Future<String> uploadEventPic({required File file,required String eventName}) async {
    User? user = auth.currentUser;
    final reference = _storage.ref("eventPics/").child("event_pic_for_$eventName${user?.uid}");
    final uploading = await reference.putFile(file);
    return await reference.getDownloadURL();
  }
}