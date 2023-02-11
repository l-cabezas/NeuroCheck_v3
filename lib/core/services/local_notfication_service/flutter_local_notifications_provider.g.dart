// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_local_notifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$flutterLocalNotificationsHash() =>
    r'f6a52029b88118c87b1e69016f8d48794c6279f5';

/// See also [flutterLocalNotifications].
final flutterLocalNotificationsProvider =
    Provider<FlutterLocalNotificationsPlugin>(
  flutterLocalNotifications,
  name: r'flutterLocalNotificationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flutterLocalNotificationsHash,
);
typedef FlutterLocalNotificationsRef
    = ProviderRef<FlutterLocalNotificationsPlugin>;
String _$setupFlutterLocalNotificationsHash() =>
    r'f7e10d8db91467e2ad23657db0b5ed6d166343bd';

/// See also [setupFlutterLocalNotifications].
final setupFlutterLocalNotificationsProvider =
    FutureProvider<FlutterLocalNotificationsPlugin>(
  setupFlutterLocalNotifications,
  name: r'setupFlutterLocalNotificationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$setupFlutterLocalNotificationsHash,
);
typedef SetupFlutterLocalNotificationsRef
    = FutureProviderRef<FlutterLocalNotificationsPlugin>;
