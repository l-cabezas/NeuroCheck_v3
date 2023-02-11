// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_fcm_notification_provider.dart';

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

String _$showFCMNotificationHash() =>
    r'2de198fd996256a11e3df276aafcc21188295456';

/// See also [showFCMNotification].
class ShowFCMNotificationProvider extends AutoDisposeFutureProvider<void> {
  ShowFCMNotificationProvider(
    this.message,
  ) : super(
          (ref) => showFCMNotification(
            ref,
            message,
          ),
          from: showFCMNotificationProvider,
          name: r'showFCMNotificationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$showFCMNotificationHash,
        );

  final RemoteMessage message;

  @override
  bool operator ==(Object other) {
    return other is ShowFCMNotificationProvider && other.message == message;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, message.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ShowFCMNotificationRef = AutoDisposeFutureProviderRef<void>;

/// See also [showFCMNotification].
final showFCMNotificationProvider = ShowFCMNotificationFamily();

class ShowFCMNotificationFamily extends Family<AsyncValue<void>> {
  ShowFCMNotificationFamily();

  ShowFCMNotificationProvider call(
    RemoteMessage message,
  ) {
    return ShowFCMNotificationProvider(
      message,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant ShowFCMNotificationProvider provider,
  ) {
    return call(
      provider.message,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'showFCMNotificationProvider';
}
