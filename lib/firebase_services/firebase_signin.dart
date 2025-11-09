// import 'package:firebase_auth/firebase_auth.dart';
//
// class FirebaseAuthService {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   /// Signs in user with email and password and returns true if successful.
//   static Future<bool> loginWithEmail(String email, String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return credential.user != null;
//     } on FirebaseAuthException catch (e) {
//       // Forward Firebase error message
//       throw e.message ?? 'FirebaseAuth error';
//     } catch (e) {
//       throw 'Unknown error occurred during login';
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> loginWithEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user != null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'Invalid email format.';
        case 'user-disabled':
          throw 'This user has been disabled.';
        case 'user-not-found':
          throw 'No user found with this email.';
        case 'wrong-password':
          throw 'Incorrect password.';
        case 'network-request-failed':
          throw 'Network error: Please check your internet connection.';
        default:
          throw e.message ?? 'Firebase Auth error.';
      }
    } catch (e) {
      throw 'Unknown error: ${e.toString()}';
    }
  }
}
