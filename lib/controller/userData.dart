import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constant/cons.dart';
import 'package:dating_app/model/filter.dart';
import 'package:dating_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userdata {

  Future<bool> updateUserData(Map<String,dynamic> data) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? phone = prefs.getString(Constant.phone);

  await  FirebaseFirestore.instance.collection(Constant.userTable).
      doc(phone).
      update(data).
      onError((e, _) {
        print("Error writing document: $e");
        return false;
      });
      return true;
  }

  Future<User?> myUserData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? myphone = prefs.getString(Constant.phone);

      final docSnapshot =  await FirebaseFirestore.instance.collection(Constant.userTable).
      doc(myphone).get();

    if(docSnapshot.exists && docSnapshot.data() != null) {

     return User.fromJson(docSnapshot.data()!);

    }

    return null;
  }

  Future<bool> checkliked(String phone) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? myphone = prefs.getString(Constant.phone);

      final docSnapshot =  await FirebaseFirestore.instance.collection(Constant.userFilerTable).
      doc(phone).get();

    if(docSnapshot.exists && docSnapshot.data() != null) {
      if(docSnapshot.data()!['liked'].contains(myphone)) {
        return true;
      }
    }

    return false;
  }


  Future<bool> updatefilterUserData(Map<String,dynamic> data) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? phone = prefs.getString(Constant.phone);

   await FirebaseFirestore.instance.collection(Constant.userFilerTable).
      doc(phone).
      update(data).
      onError((e, _) {
        print("Error writing document: $e");
        return false;
      });
      return true;
  }

  Future<User?> getUserData(String phone) async{


    final docSnapshot =  await FirebaseFirestore.instance.collection(Constant.userTable).
    doc(phone).get();

    if(docSnapshot.exists && docSnapshot.data() != null) {
      return User.fromJson(docSnapshot.data()!);
    }

    return null;
  }  

  Future<FilterUser?> getFilterData() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? phone = prefs.getString(Constant.phone);



    final docSnapshot =  await FirebaseFirestore.instance.collection(Constant.userFilerTable).
      doc(phone).get();

    if(docSnapshot.exists && docSnapshot.data() != null) {
      return FilterUser.fromJson(docSnapshot.data()!);
    }

    return null;

  }

  Future<List<User>> getFilteredUsers() async {

    List<User> filteredUsers = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? phone = prefs.getString(Constant.phone);

    // 1. Get filter data
    FilterUser? filter = await getFilterData();
    if (filter == null) return [];

    try {

      Query query = FirebaseFirestore.instance.collection(Constant.userTable)
          .where("age", isLessThanOrEqualTo: filter.maxAge)
          .where("age", isGreaterThanOrEqualTo: filter.minAge);

      if (filter.sex.isNotEmpty) {
        query = query.where("gender", whereIn: filter.sex);
      }

      final snapshot = await query.get();

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String,dynamic>;

          // Skip self
          if (data['phoneNumber'] == phone) continue;

          // Skip liked or disliked
          if (filter.liked.contains(data['phoneNumber']) ||
              filter.disliked.contains(data['phoneNumber'])) {
            continue;
          }

          // Only verified if required
          if (filter.onlyVerified == true && data['isVerified'] != true) {
            continue;
          }

          // Ensure interests is a List
          if (data['interests'] is! List) continue;

          List<String> userInterests = List<String>.from(data['interests']);
          bool hasCommonInterest = userInterests.any((interest) =>
              filter.mustInterest.contains(interest));

          // 3. Must have at least one common interest
          if (!hasCommonInterest) continue;

          // 4. If all checks passed, add to list
              filteredUsers.add(User.fromJson(data));
      }

      return filteredUsers;

    } catch (e, st) {
      return [];
    }
  }



  Future<List<User>> getallUsers() async {

    List<User> allUsers = [];

    try {

      final snapshot = await FirebaseFirestore.instance.collection(Constant.userTable).get();

      for (var doc in snapshot.docs) {

        final data = doc.data() as Map<String,dynamic>;

        allUsers.add(User.fromJson(data));

      }

      return allUsers;

    } catch (e, st) {
      return [];
    }
  }

   

    Future<List<User>> getlikedUsers() async {

    List<User> alldata = [];

    // 1. Get filter data
    FilterUser? filter = await getFilterData();
    if (filter == null) return [];

    for(String phone in filter.liked) {
      User? data = await getUserData(phone);
      if(data != null) {
        alldata.add(data);
      }
    }

    return alldata;
  } 

  Future<List<User>> getdislikedUsers() async {

    List<User> alldata = [];

    // 1. Get filter data
    FilterUser? filter = await getFilterData();
    if (filter == null) return [];

    for(String phone in filter.disliked) {
      User? data = await getUserData(phone);
      if(data != null) {
        alldata.add(data);
      }
    }

    return alldata;
  } 

  Future<List<User>> getMatchUsers() async {

    List<User> alldata = [];

    // 1. Get filter data
    FilterUser? filter = await getFilterData();
    if (filter == null) return [];

    for(String phone in filter.liked) {

      bool match = await checkliked(phone);

      if(match) {
      User? data = await getUserData(phone);

      if(data != null) {
         alldata.add(data);     
      }
      }
    }

    return alldata;
  } 


}
