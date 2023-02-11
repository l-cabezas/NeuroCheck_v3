// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_provider.dart';

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

String _$fcmHash() => r'8af107ce8b7d6a6b400981a32a252885bd1d9d93';

/// See also [fcm].
final fcmProvider = Provider<FirebaseMessaging>(
  fcm,
  name: r'fcmProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fcmHash,
);
typedef FcmRef = ProviderRef<FirebaseMessaging>;
String _$setupFCMHash() => r'b3f5b5d4a4791d525b766455771236e62b281244';

/// See also [setupFCM].
final setupFCMProvider = AutoDisposeFutureProvider<void>(
  setupFCM,
  name: r'setupFCMProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$setupFCMHash,
);
typedef SetupFCMRef = AutoDisposeFutureProviderRef<void>;
String _$_grantFCMPermissionHash() =>
    r'97eb83c1555f866c02bd5854ed63b800f13b52a6';

/// See also [_grantFCMPermission].
final _grantFCMPermissionProvider =
    AutoDisposeFutureProvider<AuthorizationStatus>(
  _grantFCMPermission,
  name: r'_grantFCMPermissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_grantFCMPermissionHash,
);
typedef _GrantFCMPermissionRef
    = AutoDisposeFutureProviderRef<AuthorizationStatus>;
String _$_setupAndroidHeadsUpHash() =>
    r'd5e832e7c4b869242ec81c996b7afa7ee985aa3a';

/// See also [_setupAndroidHeadsUp].
final _setupAndroidHeadsUpProvider = AutoDisposeFutureProvider<void>(
  _setupAndroidHeadsUp,
  name: r'_setupAndroidHeadsUpProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_setupAndroidHeadsUpHash,
);
typedef _SetupAndroidHeadsUpRef = AutoDisposeFutureProviderRef<void>;
String _$_setupIOSHeadsUpHash() => r'5c2f6148e0d92fb6fefd98e5f69bc62425acec34';

/// See also [_setupIOSHeadsUp].
final _setupIOSHeadsUpProvider = AutoDisposeFutureProvider<void>(
  _setupIOSHeadsUp,
  name: r'_setupIOSHeadsUpProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_setupIOSHeadsUpHash,
);
typedef _SetupIOSHeadsUpRef = AutoDisposeFutureProviderRef<void>;
