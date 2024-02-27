import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/event_module/model/add_event_model.dart';
import 'package:where_hearts_meet/profile_module/model/people_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import '../model/user_info_model.dart';

class FirebaseFireStoreController extends BaseController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> userSetup({required UserInfoModel userInfoModel}) async {
    User? user = auth.currentUser;
    final store = fireStore.collection('Users').doc(user?.uid);
    await store.set(userInfoModel.toJson());
  }
  Future<void> updateUserData({required UserInfoModel userInfoModel}) async {
    User? user = auth.currentUser;
    final store = fireStore.collection('Users').doc(user?.uid);
    await store.update(userInfoModel.toJson());
    await user?.updateDisplayName(userInfoModel.name);
  }

  Future<bool> addPeople({required PeopleModel peopleModel}) async {
    final currentUser = await getCurrentUserFromFireStore();
    if (currentUser != null) {
      final addPeopleStore = fireStore.collection('Users').doc(peopleModel.uid);
      await addPeopleStore.set(peopleModel.toJson());

      final userStore = fireStore.collection('Users').doc(currentUser.uid);
      final data = await userStore.get();
      if (data.data() != null) {
        final user = UserInfoModel.fromJson(data.data()!);
        if (user.peopleList != null) {
          bool canAdd=true;
          for(String data in user.peopleList ??[]){
            if(data == peopleModel.uid){
              canAdd=false;
              break;
            }
          }
          if(canAdd){
            user.peopleList?.add(addPeopleStore.id);
            await userSetup(userInfoModel: user);
            return true;
          }else{
            showSnackBar(context: Get.context!,message: 'User already added');
            return false;
          }

        }
      }
    }
    return false;
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

  Future<UserInfoModel?> getCurrentUserFromFireStore() async {
    User? user = auth.currentUser;
    final store = fireStore.collection('Users').doc(user?.uid);

    final data = await store.get();
    if (data.data() != null) {
      return UserInfoModel.fromJson(data.data()!);
    }
    return null;
  }

  Future<List<PeopleModel>> getPeopleList() async {
    final store = fireStore.collection('Users');
    final dataList = await store.get();
    final allPeopleList = dataList.docs.map((element) => PeopleModel.fromJson(element.data())).toList();

    final user = await getCurrentUserFromFireStore();
    List<PeopleModel> list = [];
    if (user != null) {
      var peopleList = user.peopleList ?? [];

      for (var currentPeopleId in peopleList) {
        for (var allListUser in allPeopleList) {
          if (currentPeopleId == allListUser.uid) {
            list.add(allListUser);
          }
        }
      }
    }

    return list;
  }
  ///same as getPeopleList
  Future<List<PeopleModel>> getPeopleListFromModel({required List<String > peopleListFromModel}) async {
    final store = fireStore.collection('Users');
    final dataList = await store.get();
    final allPeopleList = dataList.docs.map((element) => PeopleModel.fromJson(element.data())).toList();

    List<PeopleModel> list = [];
    var peopleList = peopleListFromModel;

    for (var currentPeopleId in peopleList) {
      for (var allListUser in allPeopleList) {
        if (currentPeopleId == allListUser.uid) {
          list.add(allListUser);
        }
      }
    }

    return list;
  }
  void getInnerCollection()async{

    final store1 = fireStore.collection('Users');
    final ref1 = store1.doc('303igPtPwYP1QUemh9iQIzOXARK2');
     final store2 = ref1.collection('Peoples');

    final dataList = await store2.get();

    final list=dataList.docs.map((e) => {'name':e}).toList();
    log('called  ${ list.length}');

  }

  Future<void> deletePeople({required String uid}) async {
    final currentUser = await getCurrentUserFromFireStore();

    if (currentUser != null) {
      var peopleList = currentUser.peopleList ?? [];
      peopleList.remove(uid);
      final store = fireStore.collection('Users').doc(currentUser.uid);
      await store.set(currentUser.toJson());
    }
  }

  Future<void> deleteCreatedEvent({required String eventId}) async {
    final store = fireStore.collection('Events').doc(eventId);
    await store.delete();
  }
}
