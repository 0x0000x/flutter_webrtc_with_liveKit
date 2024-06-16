import 'dart:async';

import 'package:application_webrtc/views/auth_view.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../core/app_export.dart';
import '../../services/appwrite_service.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Instances
  // final _auth = FirebaseAuth.instance;
  late final Account _account;
  late User _appwriteUser;
  final _client = AppwriteService.getClient();

  @override
  void onInit() async {
    Logger.debugPrint('Initializing Auth Service');
    _account = Account(_client);

    // await logout();

    super.onInit();
  }

  @override
  void onReady() async {
    await _setInitialScreen();
  }

  /// [_setInitialScreen] -- set the first view when the app is opened
  Future<void> _setInitialScreen() async {
    try {
      _appwriteUser = await _account.get();
      yaUser = Rx<User>(_appwriteUser);
      Logger.debugPrint(_appwriteUser.toMap());
      Logger.debugPrint('User is Logged in');
      Get.to(() => const MainView());
      // return true;
    } catch (e) {
      Logger.debugPrint('User is not Logged in');
      Get.to(() => const AuthView());
      // return false;
    }
  }

  /// [continueWithGoogle] -- Login || Signup with google
  Future<void> continueWithGoogle() async {
    await _account.createOAuth2Session(provider: 'google');
    _appwriteUser = await _account.get();
    await _setInitialScreen();
    Logger.debugPrint('User created');
    // await isUserLoggedIn();
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await _account
        .createEmailSession(email: email, password: password)
        .then((value) {});

    await _setInitialScreen();
    // Logger.debugPrint(_appwriteUser!.value.email);
    // await isUserLoggedIn();
    // await addRegistrationTokentoSubscribedDiscussions();
  }

  /// [logout] -- Logout by deleting the current session
  Future<void> logout() async {
    await _account.deleteSession(sessionId: 'current');
    await _setInitialScreen();
  }
}
