// import 'package:eproject_currensee/data/repositories/user/user_repository.dart';
// import 'package:eproject_currensee/features/authentications/screens/countries_list/select_country_page.dart';
// import 'package:eproject_currensee/features/authentications/screens/login/login.dart';
// import 'package:eproject_currensee/features/authentications/screens/onboarding/on_boarding.dart';
// import 'package:eproject_currensee/features/authentications/screens/signup/widgets/verify_email.dart';
// import 'package:eproject_currensee/navigation_menu.dart';
// import 'package:eproject_currensee/utils/exceptions/firebase_auth_exceptions.dart';
// import 'package:eproject_currensee/utils/exceptions/firebase_exceptions.dart';
// import 'package:eproject_currensee/utils/exceptions/format_exceptions.dart';
// import 'package:eproject_currensee/utils/exceptions/platform_exceptions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthenticationRepository extends GetxController {
//   static AuthenticationRepository get instance => Get.find();
//   final deviceStorage = GetStorage();
//   final _auth = FirebaseAuth.instance;

//   User? get authUser => _auth.currentUser;
//   @override
//   void onReady() {
//     FlutterNativeSplash.remove();
//     screenRedirect();
//   }

//   screenRedirect() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       if (user.emailVerified) {
//         Get.offAll(() => NavigationMenu());
//       } else {
//         Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
//       }
//     } else {
//       deviceStorage.writeIfNull('IsFirstTime', true);
//       deviceStorage.read('IsFirstTime') != true
//           ? Get.off(() => CountrySelectionScreen())
//           : Get.off(OnBoardingScreen());
//     }
//   }

//   Future<UserCredential> loginWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went Wrong. please try again';
//     }
//   }

//   Future<UserCredential> registerWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       return await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went Wrong. please try again';
//     }
//   }

//   Future<void> sendEmailVerification() async {
//     try {
//       await _auth.currentUser?.sendEmailVerification();
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went Wrong. Please Try Again';
//     }
//   }

//   Future<void> sendPasswordResetEmail(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went Wrong. Please Try Again';
//     }
//   }

//   Future<void> reAuthenticationEmailAndPasswordUser(
//       String email, String password) async {
//     try {
//       AuthCredential credential =
//           EmailAuthProvider.credential(email: email, password: password);
//       await _auth.currentUser!.reauthenticateWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went Wrong. Please Try Again';
//     }
//   }

//   Future<UserCredential?> sendInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

//       final GoogleSignInAuthentication? googleAuth =
//           await userAccount?.authentication;

//       final credentials = GoogleAuthProvider.credential(
//           accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

//       return await _auth.signInWithCredential(credentials);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       if (kDebugMode) print('Something went Wrong : $e');
//       return null;
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await GoogleSignIn().signOut();
//       await FirebaseAuth.instance.signOut();
//       Get.offAll(() => LoginScreen());
//       Get.offAll(() => LoginScreen());
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went Wrong. Please Try Again';
//     }
//   }

//   Future<void> deleteAccount() async {
//     try {
//       await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
//       await _auth.currentUser?.delete();
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went Wrong. Please Try Again';

//     }
//   }

  
// }


// ignore_for_file: unused_import

import 'package:eproject_currensee/data/repositories/user/user_repository.dart';
import 'package:eproject_currensee/features/authentications/screens/countries_list/select_country_page.dart';
import 'package:eproject_currensee/features/authentications/screens/login/login.dart';
import 'package:eproject_currensee/features/authentications/screens/onboarding/on_boarding.dart';
import 'package:eproject_currensee/features/authentications/screens/signup/widgets/verify_email.dart';
import 'package:eproject_currensee/navigation_menu.dart';
import 'package:eproject_currensee/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:eproject_currensee/utils/exceptions/firebase_exceptions.dart';
import 'package:eproject_currensee/utils/exceptions/format_exceptions.dart';
import 'package:eproject_currensee/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    Future.delayed(Duration.zero, () {
      screenRedirect();
    });
  }

  /// 🚀 Screen Redirect Fix for Contextless Navigation
  void screenRedirect() async {
    final user = _auth.currentUser;
    Future.delayed(Duration.zero, () {
      if (user != null) {
        if (user.emailVerified) {
          Get.offAll(() => NavigationMenu());
        } else {
          Get.offAll(() => VerifyEmailScreen(email: user.email));
        }
      } else {
        deviceStorage.writeIfNull('IsFirstTime', true);
        bool isFirstTime = deviceStorage.read('IsFirstTime') ?? true;
        Get.off(() => isFirstTime ? OnBoardingScreen() : LoginScreen());
      }
    });
  }

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> reAuthenticationEmailAndPasswordUser(String email, String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<UserCredential?> sendInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      if (userAccount == null) return null;

      final GoogleSignInAuthentication googleAuth = await userAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credentials);
    } catch (e) {
      if (kDebugMode) print('Google Sign-In Error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      //await GoogleSignIn().signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await UserRepository.instance.removeUserRecord(user.uid);
        await user.delete();
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
