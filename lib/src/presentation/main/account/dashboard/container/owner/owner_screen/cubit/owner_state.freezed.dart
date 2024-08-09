// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OwnerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<StoreModel> stores) loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<StoreModel> stores)? loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<StoreModel> stores)? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OwnerStateLoading value) loading,
    required TResult Function(OwnerStateLoaded value) loaded,
    required TResult Function(OwnerStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerStateLoading value)? loading,
    TResult? Function(OwnerStateLoaded value)? loaded,
    TResult? Function(OwnerStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerStateLoading value)? loading,
    TResult Function(OwnerStateLoaded value)? loaded,
    TResult Function(OwnerStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerStateCopyWith<$Res> {
  factory $OwnerStateCopyWith(
          OwnerState value, $Res Function(OwnerState) then) =
      _$OwnerStateCopyWithImpl<$Res, OwnerState>;
}

/// @nodoc
class _$OwnerStateCopyWithImpl<$Res, $Val extends OwnerState>
    implements $OwnerStateCopyWith<$Res> {
  _$OwnerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OwnerStateLoadingImplCopyWith<$Res> {
  factory _$$OwnerStateLoadingImplCopyWith(_$OwnerStateLoadingImpl value,
          $Res Function(_$OwnerStateLoadingImpl) then) =
      __$$OwnerStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerStateLoadingImplCopyWithImpl<$Res>
    extends _$OwnerStateCopyWithImpl<$Res, _$OwnerStateLoadingImpl>
    implements _$$OwnerStateLoadingImplCopyWith<$Res> {
  __$$OwnerStateLoadingImplCopyWithImpl(_$OwnerStateLoadingImpl _value,
      $Res Function(_$OwnerStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OwnerStateLoadingImpl implements OwnerStateLoading {
  const _$OwnerStateLoadingImpl();

  @override
  String toString() {
    return 'OwnerState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OwnerStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<StoreModel> stores) loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<StoreModel> stores)? loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<StoreModel> stores)? loaded,
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
    required TResult Function(OwnerStateLoading value) loading,
    required TResult Function(OwnerStateLoaded value) loaded,
    required TResult Function(OwnerStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerStateLoading value)? loading,
    TResult? Function(OwnerStateLoaded value)? loaded,
    TResult? Function(OwnerStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerStateLoading value)? loading,
    TResult Function(OwnerStateLoaded value)? loaded,
    TResult Function(OwnerStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OwnerStateLoading implements OwnerState {
  const factory OwnerStateLoading() = _$OwnerStateLoadingImpl;
}

/// @nodoc
abstract class _$$OwnerStateLoadedImplCopyWith<$Res> {
  factory _$$OwnerStateLoadedImplCopyWith(_$OwnerStateLoadedImpl value,
          $Res Function(_$OwnerStateLoadedImpl) then) =
      __$$OwnerStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<StoreModel> stores});
}

/// @nodoc
class __$$OwnerStateLoadedImplCopyWithImpl<$Res>
    extends _$OwnerStateCopyWithImpl<$Res, _$OwnerStateLoadedImpl>
    implements _$$OwnerStateLoadedImplCopyWith<$Res> {
  __$$OwnerStateLoadedImplCopyWithImpl(_$OwnerStateLoadedImpl _value,
      $Res Function(_$OwnerStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stores = null,
  }) {
    return _then(_$OwnerStateLoadedImpl(
      null == stores
          ? _value._stores
          : stores // ignore: cast_nullable_to_non_nullable
              as List<StoreModel>,
    ));
  }
}

/// @nodoc

class _$OwnerStateLoadedImpl implements OwnerStateLoaded {
  const _$OwnerStateLoadedImpl(final List<StoreModel> stores)
      : _stores = stores;

  final List<StoreModel> _stores;
  @override
  List<StoreModel> get stores {
    if (_stores is EqualUnmodifiableListView) return _stores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stores);
  }

  @override
  String toString() {
    return 'OwnerState.loaded(stores: $stores)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._stores, _stores));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_stores));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerStateLoadedImplCopyWith<_$OwnerStateLoadedImpl> get copyWith =>
      __$$OwnerStateLoadedImplCopyWithImpl<_$OwnerStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<StoreModel> stores) loaded,
    required TResult Function() error,
  }) {
    return loaded(stores);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<StoreModel> stores)? loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(stores);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<StoreModel> stores)? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(stores);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OwnerStateLoading value) loading,
    required TResult Function(OwnerStateLoaded value) loaded,
    required TResult Function(OwnerStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerStateLoading value)? loading,
    TResult? Function(OwnerStateLoaded value)? loaded,
    TResult? Function(OwnerStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerStateLoading value)? loading,
    TResult Function(OwnerStateLoaded value)? loaded,
    TResult Function(OwnerStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OwnerStateLoaded implements OwnerState {
  const factory OwnerStateLoaded(final List<StoreModel> stores) =
      _$OwnerStateLoadedImpl;

  List<StoreModel> get stores;
  @JsonKey(ignore: true)
  _$$OwnerStateLoadedImplCopyWith<_$OwnerStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OwnerStateErrorImplCopyWith<$Res> {
  factory _$$OwnerStateErrorImplCopyWith(_$OwnerStateErrorImpl value,
          $Res Function(_$OwnerStateErrorImpl) then) =
      __$$OwnerStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerStateErrorImplCopyWithImpl<$Res>
    extends _$OwnerStateCopyWithImpl<$Res, _$OwnerStateErrorImpl>
    implements _$$OwnerStateErrorImplCopyWith<$Res> {
  __$$OwnerStateErrorImplCopyWithImpl(
      _$OwnerStateErrorImpl _value, $Res Function(_$OwnerStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OwnerStateErrorImpl implements OwnerStateError {
  const _$OwnerStateErrorImpl();

  @override
  String toString() {
    return 'OwnerState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OwnerStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<StoreModel> stores) loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<StoreModel> stores)? loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<StoreModel> stores)? loaded,
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
    required TResult Function(OwnerStateLoading value) loading,
    required TResult Function(OwnerStateLoaded value) loaded,
    required TResult Function(OwnerStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerStateLoading value)? loading,
    TResult? Function(OwnerStateLoaded value)? loaded,
    TResult? Function(OwnerStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerStateLoading value)? loading,
    TResult Function(OwnerStateLoaded value)? loaded,
    TResult Function(OwnerStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OwnerStateError implements OwnerState {
  const factory OwnerStateError() = _$OwnerStateErrorImpl;
}
