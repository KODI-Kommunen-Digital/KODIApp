// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_code_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QrCodeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            String? qrCodeData, String? validUntil, int? accountId)
        loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String? qrCodeData, String? validUntil, int? accountId)?
        loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String? qrCodeData, String? validUntil, int? accountId)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QrCodeStateLoading value) loading,
    required TResult Function(QrCodeStateLoadedProducts value) loaded,
    required TResult Function(QrCodeStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QrCodeStateLoading value)? loading,
    TResult? Function(QrCodeStateLoadedProducts value)? loaded,
    TResult? Function(QrCodeStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QrCodeStateLoading value)? loading,
    TResult Function(QrCodeStateLoadedProducts value)? loaded,
    TResult Function(QrCodeStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrCodeStateCopyWith<$Res> {
  factory $QrCodeStateCopyWith(
          QrCodeState value, $Res Function(QrCodeState) then) =
      _$QrCodeStateCopyWithImpl<$Res, QrCodeState>;
}

/// @nodoc
class _$QrCodeStateCopyWithImpl<$Res, $Val extends QrCodeState>
    implements $QrCodeStateCopyWith<$Res> {
  _$QrCodeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$QrCodeStateLoadingImplCopyWith<$Res> {
  factory _$$QrCodeStateLoadingImplCopyWith(_$QrCodeStateLoadingImpl value,
          $Res Function(_$QrCodeStateLoadingImpl) then) =
      __$$QrCodeStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QrCodeStateLoadingImplCopyWithImpl<$Res>
    extends _$QrCodeStateCopyWithImpl<$Res, _$QrCodeStateLoadingImpl>
    implements _$$QrCodeStateLoadingImplCopyWith<$Res> {
  __$$QrCodeStateLoadingImplCopyWithImpl(_$QrCodeStateLoadingImpl _value,
      $Res Function(_$QrCodeStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$QrCodeStateLoadingImpl implements QrCodeStateLoading {
  const _$QrCodeStateLoadingImpl();

  @override
  String toString() {
    return 'QrCodeState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QrCodeStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            String? qrCodeData, String? validUntil, int? accountId)
        loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String? qrCodeData, String? validUntil, int? accountId)?
        loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String? qrCodeData, String? validUntil, int? accountId)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QrCodeStateLoading value) loading,
    required TResult Function(QrCodeStateLoadedProducts value) loaded,
    required TResult Function(QrCodeStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QrCodeStateLoading value)? loading,
    TResult? Function(QrCodeStateLoadedProducts value)? loaded,
    TResult? Function(QrCodeStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QrCodeStateLoading value)? loading,
    TResult Function(QrCodeStateLoadedProducts value)? loaded,
    TResult Function(QrCodeStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class QrCodeStateLoading implements QrCodeState {
  const factory QrCodeStateLoading() = _$QrCodeStateLoadingImpl;
}

/// @nodoc
abstract class _$$QrCodeStateLoadedProductsImplCopyWith<$Res> {
  factory _$$QrCodeStateLoadedProductsImplCopyWith(
          _$QrCodeStateLoadedProductsImpl value,
          $Res Function(_$QrCodeStateLoadedProductsImpl) then) =
      __$$QrCodeStateLoadedProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? qrCodeData, String? validUntil, int? accountId});
}

/// @nodoc
class __$$QrCodeStateLoadedProductsImplCopyWithImpl<$Res>
    extends _$QrCodeStateCopyWithImpl<$Res, _$QrCodeStateLoadedProductsImpl>
    implements _$$QrCodeStateLoadedProductsImplCopyWith<$Res> {
  __$$QrCodeStateLoadedProductsImplCopyWithImpl(
      _$QrCodeStateLoadedProductsImpl _value,
      $Res Function(_$QrCodeStateLoadedProductsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qrCodeData = freezed,
    Object? validUntil = freezed,
    Object? accountId = freezed,
  }) {
    return _then(_$QrCodeStateLoadedProductsImpl(
      freezed == qrCodeData
          ? _value.qrCodeData
          : qrCodeData // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$QrCodeStateLoadedProductsImpl implements QrCodeStateLoadedProducts {
  const _$QrCodeStateLoadedProductsImpl(
      this.qrCodeData, this.validUntil, this.accountId);

  @override
  final String? qrCodeData;
  @override
  final String? validUntil;
  @override
  final int? accountId;

  @override
  String toString() {
    return 'QrCodeState.loaded(qrCodeData: $qrCodeData, validUntil: $validUntil, accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrCodeStateLoadedProductsImpl &&
            (identical(other.qrCodeData, qrCodeData) ||
                other.qrCodeData == qrCodeData) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, qrCodeData, validUntil, accountId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QrCodeStateLoadedProductsImplCopyWith<_$QrCodeStateLoadedProductsImpl>
      get copyWith => __$$QrCodeStateLoadedProductsImplCopyWithImpl<
          _$QrCodeStateLoadedProductsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            String? qrCodeData, String? validUntil, int? accountId)
        loaded,
    required TResult Function() error,
  }) {
    return loaded(qrCodeData, validUntil, accountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String? qrCodeData, String? validUntil, int? accountId)?
        loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(qrCodeData, validUntil, accountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String? qrCodeData, String? validUntil, int? accountId)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(qrCodeData, validUntil, accountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QrCodeStateLoading value) loading,
    required TResult Function(QrCodeStateLoadedProducts value) loaded,
    required TResult Function(QrCodeStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QrCodeStateLoading value)? loading,
    TResult? Function(QrCodeStateLoadedProducts value)? loaded,
    TResult? Function(QrCodeStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QrCodeStateLoading value)? loading,
    TResult Function(QrCodeStateLoadedProducts value)? loaded,
    TResult Function(QrCodeStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class QrCodeStateLoadedProducts implements QrCodeState {
  const factory QrCodeStateLoadedProducts(
      final String? qrCodeData,
      final String? validUntil,
      final int? accountId) = _$QrCodeStateLoadedProductsImpl;

  String? get qrCodeData;
  String? get validUntil;
  int? get accountId;
  @JsonKey(ignore: true)
  _$$QrCodeStateLoadedProductsImplCopyWith<_$QrCodeStateLoadedProductsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QrCodeStateErrorImplCopyWith<$Res> {
  factory _$$QrCodeStateErrorImplCopyWith(_$QrCodeStateErrorImpl value,
          $Res Function(_$QrCodeStateErrorImpl) then) =
      __$$QrCodeStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QrCodeStateErrorImplCopyWithImpl<$Res>
    extends _$QrCodeStateCopyWithImpl<$Res, _$QrCodeStateErrorImpl>
    implements _$$QrCodeStateErrorImplCopyWith<$Res> {
  __$$QrCodeStateErrorImplCopyWithImpl(_$QrCodeStateErrorImpl _value,
      $Res Function(_$QrCodeStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$QrCodeStateErrorImpl implements QrCodeStateError {
  const _$QrCodeStateErrorImpl();

  @override
  String toString() {
    return 'QrCodeState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QrCodeStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            String? qrCodeData, String? validUntil, int? accountId)
        loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String? qrCodeData, String? validUntil, int? accountId)?
        loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String? qrCodeData, String? validUntil, int? accountId)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QrCodeStateLoading value) loading,
    required TResult Function(QrCodeStateLoadedProducts value) loaded,
    required TResult Function(QrCodeStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QrCodeStateLoading value)? loading,
    TResult? Function(QrCodeStateLoadedProducts value)? loaded,
    TResult? Function(QrCodeStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QrCodeStateLoading value)? loading,
    TResult Function(QrCodeStateLoadedProducts value)? loaded,
    TResult Function(QrCodeStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class QrCodeStateError implements QrCodeState {
  const factory QrCodeStateError() = _$QrCodeStateErrorImpl;
}
