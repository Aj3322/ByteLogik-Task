import 'package:byte_logik_task/app/data/model/user_model.dart';
import 'package:byte_logik_task/app/data/service/user_service.dart';
import 'package:byte_logik_task/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../modules/auth/widgets/Email_sent.dart';
import '../../routes/app_pages.dart';
import 'package:flutter/material.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userService = Get.find<UserService>();

  // Observable User object that can hold null values
  Rxn<User?> firebaseUser = Rxn<User?>();

  // Observing authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  void onInit() {
    super.onInit();
    // Bind the Firebase stream to the Rx variable
    firebaseUser.bindStream(_auth.authStateChanges());
    // Listen for authentication state changes
    ever(firebaseUser, _handleAuthChanged);
  }

  // Handle authentication changes
  void _handleAuthChanged(User? user) {
    if (user == null) {
      // User is logged out, navigate to login page
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  // Map FirebaseAuth errors to user-friendly messages
  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use by another account.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email and password sign in is not enabled.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This account has been disabled by an administrator.';
      case 'user-not-found' || 'invalid-credential':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password provided.';
      case 'too-many-requests':
        return 'Too many login attempts. Try again later.';
      default:
        print(e.code);
        return 'An unknown error occurred. Please try again.';
    }
  }

  // Method to sign up a new user using email and password
  Future<String?> signUpWithEmail(
      String email, String password, String name) async {
    // try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;

    // After sign up, save user info to Firestore
    if (user != null) {
      UserModel newUserModel = UserModel(
          id: user.uid,
          username: name,
          counterValue: 0,
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
          email: email);
      userService.postUser(newUserModel);
      return null;
    }
    // } on FirebaseAuthException catch (e) {
    //   return _handleFirebaseAuthError(e);
    // } catch (e) {
    //   return 'An unexpected error occurred: $e';
    // }
    return 'Sign up failed';
  }

  // Method to log in a user using email and password
  Future<String?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      UserModel? userModel = await userService.getUser();
      userModel?.lastLogin = DateTime.now();
      if (user != null) {
        // Update last login time
        userService.updateUser(userModel!);
        return null; // Success
      }
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
          title: e.code,
          content: Column(
            children: [
              Text(e.message.toString()),
              TextButton(onPressed: () => Get.back(), child: const Text('Ok'))
            ],
          ));
      return _handleFirebaseAuthError(e);
    } catch (e) {
      return 'An unexpected error occurred: $e';
    }
    return 'Login failed';
  }

  // Method to log out the currently authenticated user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  // Method to send a password reset email
  Future<String?> resetPassword(String email) async {
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((value)=>Get.defaultDialog(title:'',content: const EmailSentDialog()));
      return 'A password reset link has been sent to your email.';
    } on FirebaseAuthException catch (e) {
      Get.dialog(Scaffold(
        appBar: AppBar(
          title: Text("Failed to send Email"),
        ),
        body: Text(e.message.toString()),
      ));
      return _handleFirebaseAuthError(e);
    } catch (e) {
      return 'An unexpected error occurred: $e';
    }
  }

  // Method to update the user's password (user must be logged in)
  Future<String?> updatePassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        await user.reload();
        user = _auth.currentUser;
        return 'Password updated successfully.';
      }
      return 'User is not logged in.';
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthError(e);
    } catch (e) {
      return 'An unexpected error occurred: $e';
    }
  }

  // Method to log in or sign up based on user existence
  Future<String?> loginOrSignUp(
      String email, String password, String name) async {
    try {
      String? loginError = await loginWithEmail(email, password);
      if (loginError != null) {
        String? signUpError = await signUpWithEmail(email, password, name);
        return signUpError;
      }
      return null; // Login success
    } catch (e) {
      return 'An unexpected error occurred: $e';
    }
  }
}
