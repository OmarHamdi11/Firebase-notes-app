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
    apiKey: 'AIzaSyCB9oBWz12s2q1yOk8NLqvM6CUEPfQ6j58',
    appId: '1:1068979930604:web:74796267fa6fcc82a0acc9',
    messagingSenderId: '1068979930604',
    projectId: 'fir-project-827ee',
    authDomain: 'fir-project-827ee.firebaseapp.com',
    storageBucket: 'fir-project-827ee.appspot.com',
    measurementId: 'G-FX51R4N0ER',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXPNsZCRsJublMoSUtm0iDxoK4_kixURI',
    appId: '1:1068979930604:android:aa91c353e8e7c080a0acc9',
    messagingSenderId: '1068979930604',
    projectId: 'fir-project-827ee',
    storageBucket: 'fir-project-827ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFR0cmEXdUQegu_uAGKUDtB7Mie2JDIzE',
    appId: '1:1068979930604:ios:d61c50054f7a843ca0acc9',
    messagingSenderId: '1068979930604',
    projectId: 'fir-project-827ee',
    storageBucket: 'fir-project-827ee.appspot.com',
    iosBundleId: 'com.example.firebaseProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFR0cmEXdUQegu_uAGKUDtB7Mie2JDIzE',
    appId: '1:1068979930604:ios:d61c50054f7a843ca0acc9',
    messagingSenderId: '1068979930604',
    projectId: 'fir-project-827ee',
    storageBucket: 'fir-project-827ee.appspot.com',
    iosBundleId: 'com.example.firebaseProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCB9oBWz12s2q1yOk8NLqvM6CUEPfQ6j58',
    appId: '1:1068979930604:web:39f48ed9c48135b4a0acc9',
    messagingSenderId: '1068979930604',
    projectId: 'fir-project-827ee',
    authDomain: 'fir-project-827ee.firebaseapp.com',
    storageBucket: 'fir-project-827ee.appspot.com',
    measurementId: 'G-S8CCP09VV5',
  );
}
