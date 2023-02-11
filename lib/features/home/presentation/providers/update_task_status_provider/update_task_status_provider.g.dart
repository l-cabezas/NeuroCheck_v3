// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_status_provider.dart';

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

String _$updateTaskStatusStateHash() =>
    r'75afa9e6b506ef2ab5075b137e9dc22a3830e5f0';

/// See also [updateTaskStatusState].
final updateTaskStatusStateProvider =
    AutoDisposeProvider<AsyncValue<UpdateTaskStatusState>>(
  updateTaskStatusState,
  name: r'updateTaskStatusStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateTaskStatusStateHash,
);
typedef UpdateTaskStatusStateRef
    = AutoDisposeProviderRef<AsyncValue<UpdateTaskStatusState>>;
String _$updateTaskStatusHash() => r'03fee3cb820d57ffc7e77e10f01b57c17a5b0997';

/// See also [updateTaskStatus].
class UpdateTaskStatusProvider
    extends AutoDisposeFutureProvider<UpdateTaskStatusState> {
  UpdateTaskStatusProvider(
    this.params,
  ) : super(
          (ref) => updateTaskStatus(
            ref,
            params,
          ),
          from: updateTaskStatusProvider,
          name: r'updateTaskStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateTaskStatusHash,
        );

  final UpdateTaskStatusParams params;

  @override
  bool operator ==(Object other) {
    return other is UpdateTaskStatusProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef UpdateTaskStatusRef
    = AutoDisposeFutureProviderRef<UpdateTaskStatusState>;

/// See also [updateTaskStatus].
final updateTaskStatusProvider = UpdateTaskStatusFamily();

class UpdateTaskStatusFamily extends Family<AsyncValue<UpdateTaskStatusState>> {
  UpdateTaskStatusFamily();

  UpdateTaskStatusProvider call(
    UpdateTaskStatusParams params,
  ) {
    return UpdateTaskStatusProvider(
      params,
    );
  }

  @override
  AutoDisposeFutureProvider<UpdateTaskStatusState> getProviderOverride(
    covariant UpdateTaskStatusProvider provider,
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
  String? get name => r'updateTaskStatusProvider';
}
