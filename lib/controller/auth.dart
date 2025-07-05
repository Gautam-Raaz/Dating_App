import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constant/cons.dart';
import 'package:dating_app/model/filter.dart';
import 'package:dating_app/model/user.dart';

class Auth {


  Future<bool> signUp(User userData,FilterUser filter) async{

  await  FirebaseFirestore.instance.collection(Constant.userTable).
      doc(userData.phoneNumber).
      set(userData.toJson()).
      onError((e, _) {
        print("Error writing document: $e");
        return false;
      });

  await FirebaseFirestore.instance.collection(Constant.userFilerTable).
      doc(userData.phoneNumber).
      set(filter.toJson()).
      onError((e, _) {
        print("Error writing document: $e");
        return false;
      });

      return true;
  }

}