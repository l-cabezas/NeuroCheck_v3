// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppException {
  String get message => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ServerExceptionType type, String message, int? code)
        serverException,
    required TResult Function(
            CacheExceptionType type, String message, int? code)
        cacheException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ServerExceptionType type, String message, int? code)?
        serverException,
    TResult Function(CacheExceptionType type, String message, int? code)?
        cacheException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ServerExceptionType type, String message, int? code)?
        serverException,
    TResult Function(CacheExceptionType type, String message, int? code)?
        cacheException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerException value) serverException,
    required TResult Function(CacheException value) cacheException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ServerException value)? serverException,
    TResult Function(CacheException value)? cacheException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerException value)? serverException,
    TResult Function(CacheException value)? cacheException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppExceptionCopyWith<AppException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppExceptionCopyWith<$Res> {
  factory $AppExceptionCopyWith(
          AppException value, $Res Function(AppException) then) =
      _$AppExceptionCopyWithImpl<$Res>;
  $Res call({String message, int? code});
}

/// @nodoc
class _$AppExceptionCopyWithImpl<$Res> implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._value, this._then);

  final AppException _value;
  // ignore: unused_field
  final $Res Function(AppException) _then;

  @override
  $Res call({
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$ServerExceptionCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory _$$ServerExceptionCopyWith(
          _$ServerException value, $Res Function(_$ServerException) then) =
      __$$ServerExceptionCopyWithImpl<$Res>;
  @override
  $Res call({ServerExceptionType type, String message, int? code});
}

/// @nodoc
class __$$ServerExceptionCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res>
    implements _$$ServerExceptionCopyWith<$Res> {
  __$$ServerExceptionCopyWithImpl(
      _$ServerException _value, $Res Function(_$ServerException) _then)
      : super(_value, (v) => _then(v as _$ServerException));

  @override
  _$ServerException get _value => super._value as _$ServerException;

  @override
  $Res call({
    Object? type = freezed,
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(_$ServerException(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ServerExceptionType,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ServerException implements ServerException {
  const _$ServerException(
      {required this.type, required this.message, this.code});

  @override
  final ServerExceptionType type;
  @override
  final String message;
  @override
  final int? code;

  @override
  String toString() {
    return 'AppException.serverException(type: $type, message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerException &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  _$$ServerExceptionCopyWith<_$ServerException> get copyWith =>
      __$$ServerExceptionCopyWithImpl<_$ServerException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ServerExceptionType type, String message, int? code)
        serverException,
    required TResult Function(
            CacheExceptionType type, String message, int? code)
        cacheException,
  }) {
    return serverException(type, message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ServerExceptionType type, String message, int? code)?
        serverException,
    TResult Function(CacheExceptionType type, String message, int? code)?
        cacheException,
  }) {
    return serverException?.call(type, message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ServerExceptionType type, String message, int? code)?
        serverException,
    TResult Function(CacheExceptionType type, String message, int? code)?
        cacheException,
    required TResult orElse(),
  }) {
    if (serverException != null) {
      return serverException(type, message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerException value) serverException,
    required TResult Function(CacheException value) cacheException,
  }) {
    return serverException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ServerException value)? serverException,
    TResult Function(CacheException value)? cacheException,
  }) {
    return serverException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerException value)? serverException,
    TResult Function(CacheException value)? cacheException,
    required TResult orElse(),
  }) {
    if (serverException != null) {
      return serverException(this);
    }
    return orElse();
  }
}

abstract class ServerException implements AppException {
  const factory ServerException(
      {required final ServerExceptionType type,
      required final String message,
      final int? code}) = _$ServerException;

  ServerExceptionType get type;
  @override
  String get message;
  @override
  int? get code;
  @override
  @JsonKey(ignore: true)
  _$$ServerExceptionCopyWith<_$ServerException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CacheExceptionCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory _$$CacheExceptionCopyWith(
          _$CacheException value, $Res Function(_$CacheException) then) =
      __$$CacheExceptionCopyWithImpl<$Res>;
  @override
  $Res call({CacheExceptionType type, String message, int? code});
}

/// @nodoc
class __$$CacheExceptionCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res>
    implements _$$CacheExceptionCopyWith<$Res> {
  __$$CacheExceptionCopyWithImpl(
      _$CacheException _value, $Res Function(_$CacheException) _then)
      : super(_value, (v) => _then(v as _$CacheException));

  @override
  _$CacheException get _value => super._value as _$CacheException;

  @override
  $Res call({
    Object? type = freezed,
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(_$CacheException(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CacheExceptionType,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CacheException implements CacheException {
  const _$CacheException(
      {required this.type, required this.message, this.code});

  @override
  final CacheExceptionType type;
  @override
  final String message;
  @override
  final int? code;

  @override
  String toString() {
    return 'AppException.cacheException(type: $type, message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheException &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  _$$CacheExceptionCopyWith<_$CacheException> get copyWith =>
      __$$CacheExceptionCopyWithImpl<_$CacheException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ServerExceptionType type, String message, int? code)
        serverException,
    required TResult Function(
            CacheExceptionType type, String message, int? code)
        cacheException,
  }) {
    return cacheException(type, message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ServerExceptionType type, String message, int? code)?
        serverException,
    TResult Function(CacheExceptionType type, String message, int? code)?
        cacheException,
  }) {
    return cacheException?.call(type, message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ServerExceptionType type, String message, int? code)?
        serverException,
    TResult Function(CacheExceptionType type, String message, int? code)?
        cacheException,
    required TResult orElse(),
  }) {
    if (cacheException != null) {
      return cacheException(type, message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerException value) serverException,
    required TResult Function(CacheException value) cacheException,
  }) {
    return cacheException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ServerException value)? serverException,
    TResult Function(CacheException value)? cacheException,
  }) {
    return cacheException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerException value)? serverException,
    TResult Function(CacheException value)? cacheException,
    required TResult orElse(),
  }) {
    if (cacheException != null) {
      return cacheException(this);
    }
    return orElse();
  }
}

abstract class CacheException implements AppException {
  const factory CacheException(
      {required final CacheExceptionType type,
      required final String message,
      final int? code}) = _$CacheException;

  CacheExceptionType get type;
  @override
  String get message;
  @override
  int? get code;
  @override
  @JsonKey(ignore: true)
  _$$CacheExceptionCopyWith<_$CacheException> get copyWith =>
      throw _privateConstructorUsedError;
}
