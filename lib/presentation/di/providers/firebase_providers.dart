import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<FirebaseAnalytics?> firebaseAnalyticsProvider =
    Provider<FirebaseAnalytics?>((ref) => null);
final Provider<FirebaseRemoteConfig?> remoteConfigProvider =
    Provider<FirebaseRemoteConfig?>((ref) => null);
final Provider<FirebaseAuth?> firebaseAuthProvider =
    Provider<FirebaseAuth?>((ref) => null);
final Provider<FirebaseFirestore?> firestoreProvider =
    Provider<FirebaseFirestore?>((ref) => null);
final Provider<FirebaseDatabase?> databaseProvider =
    Provider<FirebaseDatabase?>((ref) => null);
final Provider<FirebaseStorage?> storageProvider =
    Provider<FirebaseStorage?>((ref) => null);
