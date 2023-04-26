import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fullstore/models/usermodel.dart';

class UserAuthentication {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  static Future<String> createAccount({required UserModel userModel}) async {
    try {
      User? user;

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

      await firestore
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
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'logged in';
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  static Future<void> logout() async => await firebaseAuth.signOut();

  static Future<void> sendVerification() async =>
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

  static String get dispalyname => firebaseAuth.currentUser!.displayName!;
  static String get email => firebaseAuth.currentUser!.email!;

  static bool get isVerified => firebaseAuth.currentUser!.emailVerified;

  // UPDATE USER LOCATION WHICH WAS SET TO NULL WHEN AUTHENTICATING

  static Future<void> updateLocation({required String location}) async {
    firestore.collection('users').doc(email).update(
      {
        'location': location,
      },
    );
  }

  static Future<Map<String, dynamic>?> getuserInformation() async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(email).get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return data;
  }
}
