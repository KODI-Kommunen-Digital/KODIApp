// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OwnerProductsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ContainerProductModel> products) loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ContainerProductModel> products)? loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ContainerProductModel> products)? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OwnerProductsStateLoading value) loading,
    required TResult Function(OwnerProductsStateLoaded value) loaded,
    required TResult Function(OwnerProductsStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerProductsStateLoading value)? loading,
    TResult? Function(OwnerProductsStateLoaded value)? loaded,
    TResult? Function(OwnerProductsStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerProductsStateLoading value)? loading,
    TResult Function(OwnerProductsStateLoaded value)? loaded,
    TResult Function(OwnerProductsStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerProductsStateCopyWith<$Res> {
  factory $OwnerProductsStateCopyWith(
          OwnerProductsState value, $Res Function(OwnerProductsState) then) =
      _$OwnerProductsStateCopyWithImpl<$Res, OwnerProductsState>;
}

/// @nodoc
class _$OwnerProductsStateCopyWithImpl<$Res, $Val extends OwnerProductsState>
    implements $OwnerProductsStateCopyWith<$Res> {
  _$OwnerProductsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OwnerProductsStateLoadingImplCopyWith<$Res> {
  factory _$$OwnerProductsStateLoadingImplCopyWith(
          _$OwnerProductsStateLoadingImpl value,
          $Res Function(_$OwnerProductsStateLoadingImpl) then) =
      __$$OwnerProductsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerProductsStateLoadingImplCopyWithImpl<$Res>
    extends _$OwnerProductsStateCopyWithImpl<$Res,
        _$OwnerProductsStateLoadingImpl>
    implements _$$OwnerProductsStateLoadingImplCopyWith<$Res> {
  __$$OwnerProductsStateLoadingImplCopyWithImpl(
      _$OwnerProductsStateLoadingImpl _value,
      $Res Function(_$OwnerProductsStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OwnerProductsStateLoadingImpl implements OwnerProductsStateLoading {
  const _$OwnerProductsStateLoadingImpl();

  @override
  String toString() {
    return 'OwnerProductsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerProductsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ContainerProductModel> products) loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ContainerProductModel> products)? loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ContainerProductModel> products)? loaded,
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
    required TResult Function(OwnerProductsStateLoading value) loading,
    required TResult Function(OwnerProductsStateLoaded value) loaded,
    required TResult Function(OwnerProductsStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerProductsStateLoading value)? loading,
    TResult? Function(OwnerProductsStateLoaded value)? loaded,
    TResult? Function(OwnerProductsStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerProductsStateLoading value)? loading,
    TResult Function(OwnerProductsStateLoaded value)? loaded,
    TResult Function(OwnerProductsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OwnerProductsStateLoading implements OwnerProductsState {
  const factory OwnerProductsStateLoading() = _$OwnerProductsStateLoadingImpl;
}

/// @nodoc
abstract class _$$OwnerProductsStateLoadedImplCopyWith<$Res> {
  factory _$$OwnerProductsStateLoadedImplCopyWith(
          _$OwnerProductsStateLoadedImpl value,
          $Res Function(_$OwnerProductsStateLoadedImpl) then) =
      __$$OwnerProductsStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ContainerProductModel> products});
}

/// @nodoc
class __$$OwnerProductsStateLoadedImplCopyWithImpl<$Res>
    extends _$OwnerProductsStateCopyWithImpl<$Res,
        _$OwnerProductsStateLoadedImpl>
    implements _$$OwnerProductsStateLoadedImplCopyWith<$Res> {
  __$$OwnerProductsStateLoadedImplCopyWithImpl(
      _$OwnerProductsStateLoadedImpl _value,
      $Res Function(_$OwnerProductsStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
  }) {
    return _then(_$OwnerProductsStateLoadedImpl(
      null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ContainerProductModel>,
    ));
  }
}

/// @nodoc

class _$OwnerProductsStateLoadedImpl implements OwnerProductsStateLoaded {
  const _$OwnerProductsStateLoadedImpl(
      final List<ContainerProductModel> products)
      : _products = products;

  final List<ContainerProductModel> _products;
  @override
  List<ContainerProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'OwnerProductsState.loaded(products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerProductsStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerProductsStateLoadedImplCopyWith<_$OwnerProductsStateLoadedImpl>
      get copyWith => __$$OwnerProductsStateLoadedImplCopyWithImpl<
          _$OwnerProductsStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ContainerProductModel> products) loaded,
    required TResult Function() error,
  }) {
    return loaded(products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ContainerProductModel> products)? loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ContainerProductModel> products)? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OwnerProductsStateLoading value) loading,
    required TResult Function(OwnerProductsStateLoaded value) loaded,
    required TResult Function(OwnerProductsStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerProductsStateLoading value)? loading,
    TResult? Function(OwnerProductsStateLoaded value)? loaded,
    TResult? Function(OwnerProductsStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerProductsStateLoading value)? loading,
    TResult Function(OwnerProductsStateLoaded value)? loaded,
    TResult Function(OwnerProductsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OwnerProductsStateLoaded implements OwnerProductsState {
  const factory OwnerProductsStateLoaded(
          final List<ContainerProductModel> products) =
      _$OwnerProductsStateLoadedImpl;

  List<ContainerProductModel> get products;
  @JsonKey(ignore: true)
  _$$OwnerProductsStateLoadedImplCopyWith<_$OwnerProductsStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OwnerProductsStateErrorImplCopyWith<$Res> {
  factory _$$OwnerProductsStateErrorImplCopyWith(
          _$OwnerProductsStateErrorImpl value,
          $Res Function(_$OwnerProductsStateErrorImpl) then) =
      __$$OwnerProductsStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerProductsStateErrorImplCopyWithImpl<$Res>
    extends _$OwnerProductsStateCopyWithImpl<$Res,
        _$OwnerProductsStateErrorImpl>
    implements _$$OwnerProductsStateErrorImplCopyWith<$Res> {
  __$$OwnerProductsStateErrorImplCopyWithImpl(
      _$OwnerProductsStateErrorImpl _value,
      $Res Function(_$OwnerProductsStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OwnerProductsStateErrorImpl implements OwnerProductsStateError {
  const _$OwnerProductsStateErrorImpl();

  @override
  String toString() {
    return 'OwnerProductsState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerProductsStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ContainerProductModel> products) loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ContainerProductModel> products)? loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ContainerProductModel> products)? loaded,
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
    required TResult Function(OwnerProductsStateLoading value) loading,
    required TResult Function(OwnerProductsStateLoaded value) loaded,
    required TResult Function(OwnerProductsStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerProductsStateLoading value)? loading,
    TResult? Function(OwnerProductsStateLoaded value)? loaded,
    TResult? Function(OwnerProductsStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerProductsStateLoading value)? loading,
    TResult Function(OwnerProductsStateLoaded value)? loaded,
    TResult Function(OwnerProductsStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OwnerProductsStateError implements OwnerProductsState {
  const factory OwnerProductsStateError() = _$OwnerProductsStateErrorImpl;
}
