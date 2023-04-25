import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fullstore/models/usermodel.dart';

class UserAuthentication {
  static Future<String> createAccount({required UserModel userModel}) async {
    try {
      User? user;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(
        userModel.firstName + userModel.lastName,
      );
      await user.reload();

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      await firebaseFirestore
          .collection('users')
          .doc(userModel.email)
          .set(userModel.toJson());
      return 'Account created';
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  static Future<String> loginToAccount(
      {required String email, required String password}) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'logged in';
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  static String get dispalyname =>
      FirebaseAuth.instance.currentUser!.displayName!;
  static String get email => FirebaseAuth.instance.currentUser!.email!;

  bool get isVerified => FirebaseAuth.instance.currentUser!.emailVerified;
}
