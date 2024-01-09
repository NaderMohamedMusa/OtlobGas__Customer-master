// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvvxbTo_7v93s_M9s8Ul9xgqLl3qV44JA', //**
    appId: '1:854855794911:android:c7204a444e2cc9603fa96a', //**
    messagingSenderId: '854855794911', // **
    projectId: 'otlopgas-ahmed', //**
    storageBucket: 'otlopgas-ahmed.appspot.com', //**
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAq-Q7V-I50wGNVvp1imh7eUgPs8ca6St8',
    appId: '1:55510306996:ios:8a0ca878975a3ee4de87e1',
    messagingSenderId: '55510306996',
    projectId: 'otlob-gas',
    storageBucket: 'otlob-gas.appspot.com',
    androidClientId:
        '55510306996-2v5kjmd442oq2lsiqfnbe1csmn9o839h.apps.googleusercontent.com',
    iosClientId:
        '55510306996-1nktaba6moouu04bnno9deuvlol7272u.apps.googleusercontent.com',
    iosBundleId: 'com.nofal.otlobgas.customer',
  );
}