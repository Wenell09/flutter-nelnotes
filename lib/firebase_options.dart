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
    apiKey: 'AIzaSyCKqxtGaExlI0vaEw1JdRp_R5ic7YS9ZlE',
    appId: '1:1021055180145:web:dc9af0d1c6647bbb7faad0',
    messagingSenderId: '1021055180145',
    projectId: 'nelnotes-85126',
    authDomain: 'nelnotes-85126.firebaseapp.com',
    storageBucket: 'nelnotes-85126.appspot.com',
    measurementId: 'G-K3SZWJ2S0K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvOMYO3qAE31oZHybG5cc46p5_AKMPRSo',
    appId: '1:1021055180145:android:512a2917764d59207faad0',
    messagingSenderId: '1021055180145',
    projectId: 'nelnotes-85126',
    storageBucket: 'nelnotes-85126.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkcFq-NBkEf0eqA29t2Yi47U_IWb_sy8A',
    appId: '1:1021055180145:ios:29e6a78f19637c937faad0',
    messagingSenderId: '1021055180145',
    projectId: 'nelnotes-85126',
    storageBucket: 'nelnotes-85126.appspot.com',
    iosBundleId: 'com.example.flutterNelnotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkcFq-NBkEf0eqA29t2Yi47U_IWb_sy8A',
    appId: '1:1021055180145:ios:29e6a78f19637c937faad0',
    messagingSenderId: '1021055180145',
    projectId: 'nelnotes-85126',
    storageBucket: 'nelnotes-85126.appspot.com',
    iosBundleId: 'com.example.flutterNelnotes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKqxtGaExlI0vaEw1JdRp_R5ic7YS9ZlE',
    appId: '1:1021055180145:web:63b7b3edaaf5fca57faad0',
    messagingSenderId: '1021055180145',
    projectId: 'nelnotes-85126',
    authDomain: 'nelnotes-85126.firebaseapp.com',
    storageBucket: 'nelnotes-85126.appspot.com',
    measurementId: 'G-HWT0322282',
  );
}
