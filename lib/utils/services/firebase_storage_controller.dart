import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

class FirebaseStorageController extends BaseController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadPic({required File file}) async {
    User? user = auth.currentUser;
    final reference = _storage.ref("profilePics/").child("profile_pic_${user?.uid}");
    final uploading = await reference.putFile(file);
    final imageUrl = await reference.getDownloadURL();

    return imageUrl;
  }

  Future<void> deleteProfilePic() async {
    User? user = auth.currentUser;
    final reference = _storage.ref("profilePics/").child("profile_pic_${user?.uid}");
    await reference.delete();
  }
}
