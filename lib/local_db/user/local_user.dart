import 'package:get_storage/get_storage.dart';

import '../../signup/user_modal.dart';

  final box = GetStorage();

  Future<void> saveUserLocally(UserModel user) async {
    await box.write('user', user.toMap()); // stores the whole map under 'user'
    // optionally store a token/flag
    await box.write('isLoggedIn', true);
  }

UserModel? getLocalUser() {
  final data = box.read('user'); // returns Map or null
  if (data == null) return null;
  return UserModel.fromMap(Map<String, dynamic>.from(data));
}

Future<void> deleteLocalUser() async {
  await box.remove('user');        // or await box.erase(); to clear everything
  await box.write('isLoggedIn', false);

}

