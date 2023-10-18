import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';

class FirebaseAuthController extends BaseController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmail({required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        showSnackBar(context: Get.context!, message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        showSnackBar(context: Get.context!, message: 'The account already exists for that email.');
      } else {
        showSnackBar(context: Get.context!, message: e.code);
      }
    } catch (e) {
      log('Error :: ${e.toString()}');
      showSnackBar(context: Get.context!, message: e.toString());
    }
    return null;
  }

  Future<bool> checkUserLogin() async {
    log('vvvv${auth.currentUser}');
    return auth.currentUser != null ? true : false;
  }

  User? getCurrentUser()  => auth.currentUser;

  Future<User?> loginWithEmail({required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        showSnackBar(context: Get.context!, message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        showSnackBar(context: Get.context!, message: 'Wrong password provided for that user.');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showSnackBar(context: Get.context!, message: 'Invalid user credential.');
      }
    } catch (e) {
      log('Error :: ${e.toString()}');
      showSnackBar(context: Get.context!, message: e.toString());
    }
    return null;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
