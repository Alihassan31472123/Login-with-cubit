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
    apiKey: 'AIzaSyB9AUQdLZWqNj3qpRfJHqGe6B4vtY0GMJ0',
    appId: '1:548846574993:web:4a21feeea51782a2460e30',
    messagingSenderId: '548846574993',
    projectId: 'auth-app-6d98b',
    authDomain: 'auth-app-6d98b.firebaseapp.com',
    storageBucket: 'auth-app-6d98b.appspot.com',
    measurementId: 'G-GV1LMR6XYQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAH7Vpb69uRI6DULPhicyl0ycKwH9alEdQ',
    appId: '1:548846574993:android:b82e1e667da4a1a9460e30',
    messagingSenderId: '548846574993',
    projectId: 'auth-app-6d98b',
    storageBucket: 'auth-app-6d98b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAY6Wp2lQ6X9zp_7-olKTmkPw5Y_tZzW6k',
    appId: '1:548846574993:ios:0bd8dcc272a5469c460e30',
    messagingSenderId: '548846574993',
    projectId: 'auth-app-6d98b',
    storageBucket: 'auth-app-6d98b.appspot.com',
    iosBundleId: 'com.example.authApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAY6Wp2lQ6X9zp_7-olKTmkPw5Y_tZzW6k',
    appId: '1:548846574993:ios:0bd8dcc272a5469c460e30',
    messagingSenderId: '548846574993',
    projectId: 'auth-app-6d98b',
    storageBucket: 'auth-app-6d98b.appspot.com',
    iosBundleId: 'com.example.authApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB9AUQdLZWqNj3qpRfJHqGe6B4vtY0GMJ0',
    appId: '1:548846574993:web:0bae9867e11f13b8460e30',
    messagingSenderId: '548846574993',
    projectId: 'auth-app-6d98b',
    authDomain: 'auth-app-6d98b.firebaseapp.com',
    storageBucket: 'auth-app-6d98b.appspot.com',
    measurementId: 'G-6R2YE4DGTN',
  );
}
