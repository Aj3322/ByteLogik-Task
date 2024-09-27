import 'package:byte_logik_task/app/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class UserService extends GetxService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('users');

  // Fetch a single user by ID
  Future<UserModel?> getUser() async {
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      Get.offNamed(Routes.LOGIN);
    }
    // try {
      DataSnapshot snapshot = await _dbRef.child(user!.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
        print(data);
        return UserModel.fromJson(data);
      } else {
        return null; // User not found
      }
    // } catch (e) {
    //   print("Error fetching user: $e");
    //   return null;
    // }
  }

  // Add or update user
  Future<void> postUser(UserModel user) async {
    try {
      await _dbRef.child(user.id!).set(user.toJson()); // Upload user data
     
    } catch (e) {
      Get.defaultDialog(title: e.toString());
      print("Error posting user: $e");
    }
  }

  // Delete a user by ID
  Future<void> deleteUser(String id) async {
    try {
      await _dbRef.child(id).remove();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  // Stream for real-time user data updates
  Stream<UserModel?> streamUser() {
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      Get.offNamed(Routes.LOGIN);
    }
    return _dbRef.child(user!.uid).onValue.map((event) {
      if (event.snapshot.exists) {
        Map<String, dynamic> data = Map<String, dynamic>.from(event.snapshot.value as Map);
        return UserModel.fromJson(data);
      } else {
        return null; // User not found
      }
    });
  }
  // Update the user
  Future<void> updateUser(UserModel user) async {
    try {
      await _dbRef.child(user.id!).update(user.toJson());
    } catch (e) {
      print("Error updating user: $e");
    }
  }
}
