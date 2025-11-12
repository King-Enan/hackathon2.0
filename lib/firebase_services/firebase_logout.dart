import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hktn/local_db/user/local_user.dart';

class FirebaseLogoutService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GetStorage _box = GetStorage();

  /// 🔹 Logout user completely
  static Future<void> logoutUser() async {
    try {
      // 1️⃣ Sign out from Firebase Authentication
      await _auth.signOut();
      await deleteLocalUser();
      print('✅ Firebase sign-out successful.');

      // 2️⃣ Clear local user data (from GetStorage)
      await _box.remove('user');
      print('✅ Local user data cleared.');

    } catch (e) {
      print('❌ Error during logout: $e');
      rethrow;
    }
  }
}
