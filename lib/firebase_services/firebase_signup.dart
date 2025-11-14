import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hktn/local_db/user/local_user.dart';
import '../models/user_modal.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser({
    required String firstName,
    required String lastName,
    required String address,
    required String email,
    required String phone,
    required String password,
    required String role, // 'farmer' or 'buyer'
  }) async {
    try {
      // 🔹 Ensure Firebase is initialized BEFORE any Firestore call
      // (This must be done in main.dart, not here)

      // 🔹 Create user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //final String uid = userCredential.user!.uid;

      // 🔹 Prepare user model
      final user = UserModel(
        //id: uid,
        firstName: firstName,
        lastName: lastName,
        address: address,
        email: email,
        phone: phone,
        role: role,
      );

      // 🔹 Save user details to Firestore using the Auth UID as doc ID
      // Remove any test Firestore writes that may cause channel issues
      await _firestore.collection('users').doc(email).set(user.toMap());

      print('✅ User registered successfully (UID: $email)');

      //await saveUserLocally(user);

    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      rethrow;
    } on FirebaseException catch (e) {
      print('❌ Firestore Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ General signup error: $e');
      rethrow;
    }

  }
}
