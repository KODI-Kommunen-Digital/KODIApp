// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_store_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditStoreState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(StoreModel store) loaded,
    required TResult Function(String error) error,
    required TResult Function() success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(StoreModel store)? loaded,
    TResult? Function(String error)? error,
    TResult? Function()? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(StoreModel store)? loaded,
    TResult Function(String error)? error,
    TResult Function()? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditStoreStateLoading value) loading,
    required TResult Function(EditStoreStateLoaded value) loaded,
    required TResult Function(EditStoreStateError value) error,
    required TResult Function(EditStoreStateSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditStoreStateLoading value)? loading,
    TResult? Function(EditStoreStateLoaded value)? loaded,
    TResult? Function(EditStoreStateError value)? error,
    TResult? Function(EditStoreStateSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditStoreStateLoading value)? loading,
    TResult Function(EditStoreStateLoaded value)? loaded,
    TResult Function(EditStoreStateError value)? error,
    TResult Function(EditStoreStateSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditStoreStateCopyWith<$Res> {
  factory $EditStoreStateCopyWith(
          EditStoreState value, $Res Function(EditStoreState) then) =
      _$EditStoreStateCopyWithImpl<$Res, EditStoreState>;
}

/// @nodoc
class _$EditStoreStateCopyWithImpl<$Res, $Val extends EditStoreState>
    implements $EditStoreStateCopyWith<$Res> {
  _$EditStoreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EditStoreStateLoadingImplCopyWith<$Res> {
  factory _$$EditStoreStateLoadingImplCopyWith(
          _$EditStoreStateLoadingImpl value,
          $Res Function(_$EditStoreStateLoadingImpl) then) =
      __$$EditStoreStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditStoreStateLoadingImplCopyWithImpl<$Res>
    extends _$EditStoreStateCopyWithImpl<$Res, _$EditStoreStateLoadingImpl>
    implements _$$EditStoreStateLoadingImplCopyWith<$Res> {
  __$$EditStoreStateLoadingImplCopyWithImpl(_$EditStoreStateLoadingImpl _value,
      $Res Function(_$EditStoreStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EditStoreStateLoadingImpl implements EditStoreStateLoading {
  const _$EditStoreStateLoadingImpl();

  @override
  String toString() {
    return 'EditStoreState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditStoreStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(StoreModel store) loaded,
    required TResult Function(String error) error,
    required TResult Function() success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(StoreModel store)? loaded,
    TResult? Function(String error)? error,
    TResult? Function()? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(StoreModel store)? loaded,
    TResult Function(String error)? error,
    TResult Function()? success,
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
    required TResult Function(EditStoreStateLoading value) loading,
    required TResult Function(EditStoreStateLoaded value) loaded,
    required TResult Function(EditStoreStateError value) error,
    required TResult Function(EditStoreStateSuccess value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditStoreStateLoading value)? loading,
    TResult? Function(EditStoreStateLoaded value)? loaded,
    TResult? Function(EditStoreStateError value)? error,
    TResult? Function(EditStoreStateSuccess value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditStoreStateLoading value)? loading,
    TResult Function(EditStoreStateLoaded value)? loaded,
    TResult Function(EditStoreStateError value)? error,
    TResult Function(EditStoreStateSuccess value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EditStoreStateLoading implements EditStoreState {
  const factory EditStoreStateLoading() = _$EditStoreStateLoadingImpl;
}

/// @nodoc
abstract class _$$EditStoreStateLoadedImplCopyWith<$Res> {
  factory _$$EditStoreStateLoadedImplCopyWith(_$EditStoreStateLoadedImpl value,
          $Res Function(_$EditStoreStateLoadedImpl) then) =
      __$$EditStoreStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StoreModel store});
}

/// @nodoc
class __$$EditStoreStateLoadedImplCopyWithImpl<$Res>
    extends _$EditStoreStateCopyWithImpl<$Res, _$EditStoreStateLoadedImpl>
    implements _$$EditStoreStateLoadedImplCopyWith<$Res> {
  __$$EditStoreStateLoadedImplCopyWithImpl(_$EditStoreStateLoadedImpl _value,
      $Res Function(_$EditStoreStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? store = null,
  }) {
    return _then(_$EditStoreStateLoadedImpl(
      null == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as StoreModel,
    ));
  }
}

/// @nodoc

class _$EditStoreStateLoadedImpl implements EditStoreStateLoaded {
  const _$EditStoreStateLoadedImpl(this.store);

  @override
  final StoreModel store;

  @override
  String toString() {
    return 'EditStoreState.loaded(store: $store)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditStoreStateLoadedImpl &&
            (identical(other.store, store) || other.store == store));
  }

  @override
  int get hashCode => Object.hash(runtimeType, store);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditStoreStateLoadedImplCopyWith<_$EditStoreStateLoadedImpl>
      get copyWith =>
          __$$EditStoreStateLoadedImplCopyWithImpl<_$EditStoreStateLoadedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(StoreModel store) loaded,
    required TResult Function(String error) error,
    required TResult Function() success,
  }) {
    return loaded(store);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(StoreModel store)? loaded,
    TResult? Function(String error)? error,
    TResult? Function()? success,
  }) {
    return loaded?.call(store);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(StoreModel store)? loaded,
    TResult Function(String error)? error,
    TResult Function()? success,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(store);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditStoreStateLoading value) loading,
    required TResult Function(EditStoreStateLoaded value) loaded,
    required TResult Function(EditStoreStateError value) error,
    required TResult Function(EditStoreStateSuccess value) success,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditStoreStateLoading value)? loading,
    TResult? Function(EditStoreStateLoaded value)? loaded,
    TResult? Function(EditStoreStateError value)? error,
    TResult? Function(EditStoreStateSuccess value)? success,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditStoreStateLoading value)? loading,
    TResult Function(EditStoreStateLoaded value)? loaded,
    TResult Function(EditStoreStateError value)? error,
    TResult Function(EditStoreStateSuccess value)? success,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class EditStoreStateLoaded implements EditStoreState {
  const factory EditStoreStateLoaded(final StoreModel store) =
      _$EditStoreStateLoadedImpl;

  StoreModel get store;
  @JsonKey(ignore: true)
  _$$EditStoreStateLoadedImplCopyWith<_$EditStoreStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditStoreStateErrorImplCopyWith<$Res> {
  factory _$$EditStoreStateErrorImplCopyWith(_$EditStoreStateErrorImpl value,
          $Res Function(_$EditStoreStateErrorImpl) then) =
      __$$EditStoreStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$EditStoreStateErrorImplCopyWithImpl<$Res>
    extends _$EditStoreStateCopyWithImpl<$Res, _$EditStoreStateErrorImpl>
    implements _$$EditStoreStateErrorImplCopyWith<$Res> {
  __$$EditStoreStateErrorImplCopyWithImpl(_$EditStoreStateErrorImpl _value,
      $Res Function(_$EditStoreStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$EditStoreStateErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditStoreStateErrorImpl implements EditStoreStateError {
  const _$EditStoreStateErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'EditStoreState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditStoreStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditStoreStateErrorImplCopyWith<_$EditStoreStateErrorImpl> get copyWith =>
      __$$EditStoreStateErrorImplCopyWithImpl<_$EditStoreStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(StoreModel store) loaded,
    required TResult Function(String error) error,
    required TResult Function() success,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(StoreModel store)? loaded,
    TResult? Function(String error)? error,
    TResult? Function()? success,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(StoreModel store)? loaded,
    TResult Function(String error)? error,
    TResult Function()? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditStoreStateLoading value) loading,
    required TResult Function(EditStoreStateLoaded value) loaded,
    required TResult Function(EditStoreStateError value) error,
    required TResult Function(EditStoreStateSuccess value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditStoreStateLoading value)? loading,
    TResult? Function(EditStoreStateLoaded value)? loaded,
    TResult? Function(EditStoreStateError value)? error,
    TResult? Function(EditStoreStateSuccess value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditStoreStateLoading value)? loading,
    TResult Function(EditStoreStateLoaded value)? loaded,
    TResult Function(EditStoreStateError value)? error,
    TResult Function(EditStoreStateSuccess value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class EditStoreStateError implements EditStoreState {
  const factory EditStoreStateError(final String error) =
      _$EditStoreStateErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$EditStoreStateErrorImplCopyWith<_$EditStoreStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditStoreStateSuccessImplCopyWith<$Res> {
  factory _$$EditStoreStateSuccessImplCopyWith(
          _$EditStoreStateSuccessImpl value,
          $Res Function(_$EditStoreStateSuccessImpl) then) =
      __$$EditStoreStateSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditStoreStateSuccessImplCopyWithImpl<$Res>
    extends _$EditStoreStateCopyWithImpl<$Res, _$EditStoreStateSuccessImpl>
    implements _$$EditStoreStateSuccessImplCopyWith<$Res> {
  __$$EditStoreStateSuccessImplCopyWithImpl(_$EditStoreStateSuccessImpl _value,
      $Res Function(_$EditStoreStateSuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EditStoreStateSuccessImpl implements EditStoreStateSuccess {
  const _$EditStoreStateSuccessImpl();

  @override
  String toString() {
    return 'EditStoreState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditStoreStateSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(StoreModel store) loaded,
    required TResult Function(String error) error,
    required TResult Function() success,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(StoreModel store)? loaded,
    TResult? Function(String error)? error,
    TResult? Function()? success,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(StoreModel store)? loaded,
    TResult Function(String error)? error,
    TResult Function()? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditStoreStateLoading value) loading,
    required TResult Function(EditStoreStateLoaded value) loaded,
    required TResult Function(EditStoreStateError value) error,
    required TResult Function(EditStoreStateSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditStoreStateLoading value)? loading,
    TResult? Function(EditStoreStateLoaded value)? loaded,
    TResult? Function(EditStoreStateError value)? error,
    TResult? Function(EditStoreStateSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditStoreStateLoading value)? loading,
    TResult Function(EditStoreStateLoaded value)? loaded,
    TResult Function(EditStoreStateError value)? error,
    TResult Function(EditStoreStateSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class EditStoreStateSuccess implements EditStoreState {
  const factory EditStoreStateSuccess() = _$EditStoreStateSuccessImpl;
}
