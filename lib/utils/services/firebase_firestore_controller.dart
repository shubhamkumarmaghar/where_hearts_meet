import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:where_hearts_meet/event_module/model/add_event_model.dart';
import 'package:where_hearts_meet/profile_module/model/people_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import '../model/user_info_model.dart';

class FirebaseFireStoreController extends BaseController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> userSetup({required UserInfoModel userInfoModel}) async {
    User? user = auth.currentUser;
    final store = fireStore.collection('Users').doc(user?.uid);
    await store.set(userInfoModel.toJson());
  }

  Future<void> addPeople({required PeopleModel peopleModel}) async {
    User? user = auth.currentUser;
    final store = fireStore.collection('Users').doc(user?.uid).collection('People').doc(peopleModel.email);
    await store.set(peopleModel.toJson());
  }

  Future<void> addEvent({required AddEventModel addEventModel}) async {
    final id = '${addEventModel.fromEmail}_${DateTime.now().millisecondsSinceEpoch}';
    addEventModel.eventId = id;
    final store = fireStore.collection('Events').doc(id);
    await store.set(addEventModel.toJson());
  }

  Future<List<AddEventModel>> getEventList() async {
    final store = fireStore.collection('Events');
    final dataList = await store.get();
    final list = dataList.docs.map((element) => AddEventModel.fromJson(element.data())).toList();
    return list;
  }

  Future<List<PeopleModel>> getAllUsers() async {
    final store = fireStore.collection('Users');
    User? user = auth.currentUser;
    final dataList = await store.get();
    final list = dataList.docs.map((element) => PeopleModel.fromJson(element.data())).toList();
    list.removeWhere((element) => element.email == user?.email);
    return list;
  }

  Future<UserInfoModel?> getUserByEmail({required String email}) async {
    final store = fireStore.collection('Users');
    final dataList = await store.get();
    final list = dataList.docs.map((element) => UserInfoModel.fromJson(element.data())).toList();
    for (var element in list) {
      if (element.email == email) {
        return element;
      }
    }
    return null;
  }

  Future<List<PeopleModel>> getPeopleList() async {
    User? user = auth.currentUser;
    final store = fireStore.collection('Users').doc(user?.uid).collection('People');
    final dataList = await store.get();
    final list = dataList.docs.map((element) => PeopleModel.fromJson(element.data())).toList();
    return list;
  }
  Future<void> deletePeople({required String email}) async {
    User? user = auth.currentUser;
    final store = fireStore.collection('Users').doc(user?.uid).collection('People').doc(email);
    await store.delete();
  }
  Future<void> deleteCreatedEvent({required String eventId}) async {
    User? user = auth.currentUser;
    final store = fireStore.collection('Events').doc(eventId);
    await store.delete();
  }

}
