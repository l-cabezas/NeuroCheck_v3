// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_pref_local_storage_caller.dart';

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

String _$sharedPrefsHash() => r'327fba3155b174198eb7b834b41a2e9f60b5ac49';

/// See also [sharedPrefs].
final sharedPrefsProvider = Provider<SharedPreferences>(
  sharedPrefs,
  name: r'sharedPrefsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sharedPrefsHash,
);
typedef SharedPrefsRef = ProviderRef<SharedPreferences>;
String _$localStorageCallerHash() =>
    r'1ae6d4044bf7683e5a04e2c5ac301ceaf062a209';

/// See also [localStorageCaller].
final localStorageCallerProvider = Provider<ILocalStorageCaller>(
  localStorageCaller,
  name: r'localStorageCallerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localStorageCallerHash,
);
typedef LocalStorageCallerRef = ProviderRef<ILocalStorageCaller>;
