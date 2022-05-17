// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NetworkException {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)
        $default, {
    required TResult Function() noDataException,
    required TResult Function() loadingDataException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)?
        $default, {
    TResult Function()? noDataException,
    TResult Function()? loadingDataException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)?
        $default, {
    TResult Function()? noDataException,
    TResult Function()? loadingDataException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ServerException value) $default, {
    required TResult Function(NoDataException value) noDataException,
    required TResult Function(LoadingDataException value) loadingDataException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(ServerException value)? $default, {
    TResult Function(NoDataException value)? noDataException,
    TResult Function(LoadingDataException value)? loadingDataException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ServerException value)? $default, {
    TResult Function(NoDataException value)? noDataException,
    TResult Function(LoadingDataException value)? loadingDataException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkExceptionCopyWith<$Res> {
  factory $NetworkExceptionCopyWith(
          NetworkException value, $Res Function(NetworkException) then) =
      _$NetworkExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class _$NetworkExceptionCopyWithImpl<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  _$NetworkExceptionCopyWithImpl(this._value, this._then);

  final NetworkException _value;
  // ignore: unused_field
  final $Res Function(NetworkException) _then;
}

/// @nodoc
abstract class _$$ServerExceptionCopyWith<$Res> {
  factory _$$ServerExceptionCopyWith(
          _$ServerException value, $Res Function(_$ServerException) then) =
      __$$ServerExceptionCopyWithImpl<$Res>;
  $Res call(
      {String message,
      int? statusCode,
      Object? response,
      StackTrace? stackTrace});
}

/// @nodoc
class __$$ServerExceptionCopyWithImpl<$Res>
    extends _$NetworkExceptionCopyWithImpl<$Res>
    implements _$$ServerExceptionCopyWith<$Res> {
  __$$ServerExceptionCopyWithImpl(
      _$ServerException _value, $Res Function(_$ServerException) _then)
      : super(_value, (v) => _then(v as _$ServerException));

  @override
  _$ServerException get _value => super._value as _$ServerException;

  @override
  $Res call({
    Object? message = freezed,
    Object? statusCode = freezed,
    Object? response = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$ServerException(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: statusCode == freezed
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      response: response == freezed ? _value.response : response,
      stackTrace: stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$ServerException extends ServerException {
  const _$ServerException(
      {required this.message, this.statusCode, this.response, this.stackTrace})
      : super._();

  @override
  final String message;
  @override
  final int? statusCode;
  @override
  final Object? response;
  @override
  final StackTrace? stackTrace;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerException &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.statusCode, statusCode) &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality()
                .equals(other.stackTrace, stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(statusCode),
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(stackTrace));

  @JsonKey(ignore: true)
  @override
  _$$ServerExceptionCopyWith<_$ServerException> get copyWith =>
      __$$ServerExceptionCopyWithImpl<_$ServerException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)
        $default, {
    required TResult Function() noDataException,
    required TResult Function() loadingDataException,
  }) {
    return $default(message, statusCode, response, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)?
        $default, {
    TResult Function()? noDataException,
    TResult Function()? loadingDataException,
  }) {
    return $default?.call(message, statusCode, response, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)?
        $default, {
    TResult Function()? noDataException,
    TResult Function()? loadingDataException,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(message, statusCode, response, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ServerException value) $default, {
    required TResult Function(NoDataException value) noDataException,
    required TResult Function(LoadingDataException value) loadingDataException,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(ServerException value)? $default, {
    TResult Function(NoDataException value)? noDataException,
    TResult Function(LoadingDataException value)? loadingDataException,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ServerException value)? $default, {
    TResult Function(NoDataException value)? noDataException,
    TResult Function(LoadingDataException value)? loadingDataException,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class ServerException extends NetworkException {
  const factory ServerException(
      {required final String message,
      final int? statusCode,
      final Object? response,
      final StackTrace? stackTrace}) = _$ServerException;
  const ServerException._() : super._();

  String get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  Object? get response => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ServerExceptionCopyWith<_$ServerException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoDataExceptionCopyWith<$Res> {
  factory _$$NoDataExceptionCopyWith(
          _$NoDataException value, $Res Function(_$NoDataException) then) =
      __$$NoDataExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoDataExceptionCopyWithImpl<$Res>
    extends _$NetworkExceptionCopyWithImpl<$Res>
    implements _$$NoDataExceptionCopyWith<$Res> {
  __$$NoDataExceptionCopyWithImpl(
      _$NoDataException _value, $Res Function(_$NoDataException) _then)
      : super(_value, (v) => _then(v as _$NoDataException));

  @override
  _$NoDataException get _value => super._value as _$NoDataException;
}

/// @nodoc

class _$NoDataException extends NoDataException {
  const _$NoDataException() : super._();

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoDataException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)
        $default, {
    required TResult Function() noDataException,
    required TResult Function() loadingDataException,
  }) {
    return noDataException();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)?
        $default, {
    TResult Function()? noDataException,
    TResult Function()? loadingDataException,
  }) {
    return noDataException?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)?
        $default, {
    TResult Function()? noDataException,
    TResult Function()? loadingDataException,
    required TResult orElse(),
  }) {
    if (noDataException != null) {
      return noDataException();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ServerException value) $default, {
    required TResult Function(NoDataException value) noDataException,
    required TResult Function(LoadingDataException value) loadingDataException,
  }) {
    return noDataException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(ServerException value)? $default, {
    TResult Function(NoDataException value)? noDataException,
    TResult Function(LoadingDataException value)? loadingDataException,
  }) {
    return noDataException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ServerException value)? $default, {
    TResult Function(NoDataException value)? noDataException,
    TResult Function(LoadingDataException value)? loadingDataException,
    required TResult orElse(),
  }) {
    if (noDataException != null) {
      return noDataException(this);
    }
    return orElse();
  }
}

abstract class NoDataException extends NetworkException {
  const factory NoDataException() = _$NoDataException;
  const NoDataException._() : super._();
}

/// @nodoc
abstract class _$$LoadingDataExceptionCopyWith<$Res> {
  factory _$$LoadingDataExceptionCopyWith(_$LoadingDataException value,
          $Res Function(_$LoadingDataException) then) =
      __$$LoadingDataExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingDataExceptionCopyWithImpl<$Res>
    extends _$NetworkExceptionCopyWithImpl<$Res>
    implements _$$LoadingDataExceptionCopyWith<$Res> {
  __$$LoadingDataExceptionCopyWithImpl(_$LoadingDataException _value,
      $Res Function(_$LoadingDataException) _then)
      : super(_value, (v) => _then(v as _$LoadingDataException));

  @override
  _$LoadingDataException get _value => super._value as _$LoadingDataException;
}

/// @nodoc

class _$LoadingDataException extends LoadingDataException {
  const _$LoadingDataException() : super._();

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingDataException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)
        $default, {
    required TResult Function() noDataException,
    required TResult Function() loadingDataException,
  }) {
    return loadingDataException();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)?
        $default, {
    TResult Function()? noDataException,
    TResult Function()? loadingDataException,
  }) {
    return loadingDataException?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String message, int? statusCode, Object? response,
            StackTrace? stackTrace)?
        $default, {
    TResult Function()? noDataException,
    TResult Function()? loadingDataException,
    required TResult orElse(),
  }) {
    if (loadingDataException != null) {
      return loadingDataException();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ServerException value) $default, {
    required TResult Function(NoDataException value) noDataException,
    required TResult Function(LoadingDataException value) loadingDataException,
  }) {
    return loadingDataException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(ServerException value)? $default, {
    TResult Function(NoDataException value)? noDataException,
    TResult Function(LoadingDataException value)? loadingDataException,
  }) {
    return loadingDataException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ServerException value)? $default, {
    TResult Function(NoDataException value)? noDataException,
    TResult Function(LoadingDataException value)? loadingDataException,
    required TResult orElse(),
  }) {
    if (loadingDataException != null) {
      return loadingDataException(this);
    }
    return orElse();
  }
}

abstract class LoadingDataException extends NetworkException {
  const factory LoadingDataException() = _$LoadingDataException;
  const LoadingDataException._() : super._();
}
