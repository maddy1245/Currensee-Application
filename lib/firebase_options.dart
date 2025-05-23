// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCHaH3A4DltNtE9E4S2DW1eo9RYdqUDy48',
    appId: '1:287153953753:web:a98dc3072aed071df157c8',
    messagingSenderId: '287153953753',
    projectId: 'curressee',
    authDomain: 'curressee.firebaseapp.com',
    storageBucket: 'curressee.firebasestorage.app',
    measurementId: 'G-2DZQE7EWWP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDixetBva1LqHNdpL7SQzYbVnJftlvMqhM',
    appId: '1:287153953753:android:212367a2c7749608f157c8',
    messagingSenderId: '287153953753',
    projectId: 'curressee',
    storageBucket: 'curressee.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIVPUmqoTB9ZAJnFB70zEvNguIak_buRw',
    appId: '1:287153953753:ios:80344aa4877397eff157c8',
    messagingSenderId: '287153953753',
    projectId: 'curressee',
    storageBucket: 'curressee.firebasestorage.app',
    iosClientId: '287153953753-fishunn93goq9d6g6ssk2u59drk2f14a.apps.googleusercontent.com',
    iosBundleId: 'com.example.eprojectCurrensee',
  );
}
