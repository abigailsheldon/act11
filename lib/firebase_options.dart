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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAhfSUUi8rU4s_YkwUxz4LmrpIT5I6yXcs',
    appId: '1:1076198737288:web:c900be14a7d2955598263d',
    messagingSenderId: '1076198737288',
    projectId: 'activity12-2882d',
    authDomain: 'activity12-2882d.firebaseapp.com',
    storageBucket: 'activity12-2882d.firebasestorage.app',
    measurementId: 'G-K1N16CCSLX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABW8T4DCpUmcR1Ys56SJyEo0c5yTdi0TA',
    appId: '1:1076198737288:android:12b91ddb58b4548598263d',
    messagingSenderId: '1076198737288',
    projectId: 'activity12-2882d',
    storageBucket: 'activity12-2882d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtzHesASAB7FI7lTlHlKu91f4pm4d0BeE',
    appId: '1:1076198737288:ios:8701e5b71f8cfcc898263d',
    messagingSenderId: '1076198737288',
    projectId: 'activity12-2882d',
    storageBucket: 'activity12-2882d.firebasestorage.app',
    iosBundleId: 'com.example.act11',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtzHesASAB7FI7lTlHlKu91f4pm4d0BeE',
    appId: '1:1076198737288:ios:8701e5b71f8cfcc898263d',
    messagingSenderId: '1076198737288',
    projectId: 'activity12-2882d',
    storageBucket: 'activity12-2882d.firebasestorage.app',
    iosBundleId: 'com.example.act11',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhfSUUi8rU4s_YkwUxz4LmrpIT5I6yXcs',
    appId: '1:1076198737288:web:03d4e87c6a36708398263d',
    messagingSenderId: '1076198737288',
    projectId: 'activity12-2882d',
    authDomain: 'activity12-2882d.firebaseapp.com',
    storageBucket: 'activity12-2882d.firebasestorage.app',
    measurementId: 'G-D39YYF8J72',
  );
}
