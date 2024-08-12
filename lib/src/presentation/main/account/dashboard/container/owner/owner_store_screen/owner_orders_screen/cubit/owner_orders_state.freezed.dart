// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OwnerOrdersState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OwnerOrdersStateLoading value) loading,
    required TResult Function(OwnerOrdersStateLoaded value) loaded,
    required TResult Function(OwnerOrdersStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerOrdersStateLoading value)? loading,
    TResult? Function(OwnerOrdersStateLoaded value)? loaded,
    TResult? Function(OwnerOrdersStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerOrdersStateLoading value)? loading,
    TResult Function(OwnerOrdersStateLoaded value)? loaded,
    TResult Function(OwnerOrdersStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerOrdersStateCopyWith<$Res> {
  factory $OwnerOrdersStateCopyWith(
          OwnerOrdersState value, $Res Function(OwnerOrdersState) then) =
      _$OwnerOrdersStateCopyWithImpl<$Res, OwnerOrdersState>;
}

/// @nodoc
class _$OwnerOrdersStateCopyWithImpl<$Res, $Val extends OwnerOrdersState>
    implements $OwnerOrdersStateCopyWith<$Res> {
  _$OwnerOrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OwnerOrdersStateLoadingImplCopyWith<$Res> {
  factory _$$OwnerOrdersStateLoadingImplCopyWith(
          _$OwnerOrdersStateLoadingImpl value,
          $Res Function(_$OwnerOrdersStateLoadingImpl) then) =
      __$$OwnerOrdersStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerOrdersStateLoadingImplCopyWithImpl<$Res>
    extends _$OwnerOrdersStateCopyWithImpl<$Res, _$OwnerOrdersStateLoadingImpl>
    implements _$$OwnerOrdersStateLoadingImplCopyWith<$Res> {
  __$$OwnerOrdersStateLoadingImplCopyWithImpl(
      _$OwnerOrdersStateLoadingImpl _value,
      $Res Function(_$OwnerOrdersStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OwnerOrdersStateLoadingImpl implements OwnerOrdersStateLoading {
  const _$OwnerOrdersStateLoadingImpl();

  @override
  String toString() {
    return 'OwnerOrdersState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerOrdersStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
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
    required TResult Function(OwnerOrdersStateLoading value) loading,
    required TResult Function(OwnerOrdersStateLoaded value) loaded,
    required TResult Function(OwnerOrdersStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerOrdersStateLoading value)? loading,
    TResult? Function(OwnerOrdersStateLoaded value)? loaded,
    TResult? Function(OwnerOrdersStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerOrdersStateLoading value)? loading,
    TResult Function(OwnerOrdersStateLoaded value)? loaded,
    TResult Function(OwnerOrdersStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OwnerOrdersStateLoading implements OwnerOrdersState {
  const factory OwnerOrdersStateLoading() = _$OwnerOrdersStateLoadingImpl;
}

/// @nodoc
abstract class _$$OwnerOrdersStateLoadedImplCopyWith<$Res> {
  factory _$$OwnerOrdersStateLoadedImplCopyWith(
          _$OwnerOrdersStateLoadedImpl value,
          $Res Function(_$OwnerOrdersStateLoadedImpl) then) =
      __$$OwnerOrdersStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrderModel> orders});
}

/// @nodoc
class __$$OwnerOrdersStateLoadedImplCopyWithImpl<$Res>
    extends _$OwnerOrdersStateCopyWithImpl<$Res, _$OwnerOrdersStateLoadedImpl>
    implements _$$OwnerOrdersStateLoadedImplCopyWith<$Res> {
  __$$OwnerOrdersStateLoadedImplCopyWithImpl(
      _$OwnerOrdersStateLoadedImpl _value,
      $Res Function(_$OwnerOrdersStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$OwnerOrdersStateLoadedImpl(
      null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
    ));
  }
}

/// @nodoc

class _$OwnerOrdersStateLoadedImpl implements OwnerOrdersStateLoaded {
  const _$OwnerOrdersStateLoadedImpl(final List<OrderModel> orders)
      : _orders = orders;

  final List<OrderModel> _orders;
  @override
  List<OrderModel> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'OwnerOrdersState.loaded(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerOrdersStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerOrdersStateLoadedImplCopyWith<_$OwnerOrdersStateLoadedImpl>
      get copyWith => __$$OwnerOrdersStateLoadedImplCopyWithImpl<
          _$OwnerOrdersStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function() error,
  }) {
    return loaded(orders);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(orders);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(orders);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OwnerOrdersStateLoading value) loading,
    required TResult Function(OwnerOrdersStateLoaded value) loaded,
    required TResult Function(OwnerOrdersStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerOrdersStateLoading value)? loading,
    TResult? Function(OwnerOrdersStateLoaded value)? loaded,
    TResult? Function(OwnerOrdersStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerOrdersStateLoading value)? loading,
    TResult Function(OwnerOrdersStateLoaded value)? loaded,
    TResult Function(OwnerOrdersStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OwnerOrdersStateLoaded implements OwnerOrdersState {
  const factory OwnerOrdersStateLoaded(final List<OrderModel> orders) =
      _$OwnerOrdersStateLoadedImpl;

  List<OrderModel> get orders;
  @JsonKey(ignore: true)
  _$$OwnerOrdersStateLoadedImplCopyWith<_$OwnerOrdersStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OwnerOrdersStateErrorImplCopyWith<$Res> {
  factory _$$OwnerOrdersStateErrorImplCopyWith(
          _$OwnerOrdersStateErrorImpl value,
          $Res Function(_$OwnerOrdersStateErrorImpl) then) =
      __$$OwnerOrdersStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerOrdersStateErrorImplCopyWithImpl<$Res>
    extends _$OwnerOrdersStateCopyWithImpl<$Res, _$OwnerOrdersStateErrorImpl>
    implements _$$OwnerOrdersStateErrorImplCopyWith<$Res> {
  __$$OwnerOrdersStateErrorImplCopyWithImpl(_$OwnerOrdersStateErrorImpl _value,
      $Res Function(_$OwnerOrdersStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OwnerOrdersStateErrorImpl implements OwnerOrdersStateError {
  const _$OwnerOrdersStateErrorImpl();

  @override
  String toString() {
    return 'OwnerOrdersState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerOrdersStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
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
    required TResult Function(OwnerOrdersStateLoading value) loading,
    required TResult Function(OwnerOrdersStateLoaded value) loaded,
    required TResult Function(OwnerOrdersStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerOrdersStateLoading value)? loading,
    TResult? Function(OwnerOrdersStateLoaded value)? loaded,
    TResult? Function(OwnerOrdersStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerOrdersStateLoading value)? loading,
    TResult Function(OwnerOrdersStateLoaded value)? loaded,
    TResult Function(OwnerOrdersStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OwnerOrdersStateError implements OwnerOrdersState {
  const factory OwnerOrdersStateError() = _$OwnerOrdersStateErrorImpl;
}
