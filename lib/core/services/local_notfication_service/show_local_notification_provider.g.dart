// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_local_notification_provider.dart';

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

String _$showLocalNotificationHash() =>
    r'4b1355ea09409925d9785ad98cb35ba2cf5c3623';

/// See also [showLocalNotification].
class ShowLocalNotificationProvider extends AutoDisposeFutureProvider<void> {
  ShowLocalNotificationProvider(
    this.params,
  ) : super(
          (ref) => showLocalNotification(
            ref,
            params,
          ),
          from: showLocalNotificationProvider,
          name: r'showLocalNotificationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$showLocalNotificationHash,
        );

  final ShowLocalNotificationParams params;

  @override
  bool operator ==(Object other) {
    return other is ShowLocalNotificationProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ShowLocalNotificationRef = AutoDisposeFutureProviderRef<void>;

/// See also [showLocalNotification].
final showLocalNotificationProvider = ShowLocalNotificationFamily();

class ShowLocalNotificationFamily extends Family<AsyncValue<void>> {
  ShowLocalNotificationFamily();

  ShowLocalNotificationProvider call(
    ShowLocalNotificationParams params,
  ) {
    return ShowLocalNotificationProvider(
      params,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant ShowLocalNotificationProvider provider,
  ) {
    return call(
      provider.params,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'showLocalNotificationProvider';
}
