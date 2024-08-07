// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orderSold) loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orderSold)? loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orderSold)? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomerStateLoading value) loading,
    required TResult Function(CustomerStateLoaded value) loaded,
    required TResult Function(CustomerStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomerStateLoading value)? loading,
    TResult? Function(CustomerStateLoaded value)? loaded,
    TResult? Function(CustomerStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomerStateLoading value)? loading,
    TResult Function(CustomerStateLoaded value)? loaded,
    TResult Function(CustomerStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerStateCopyWith<$Res> {
  factory $CustomerStateCopyWith(
          CustomerState value, $Res Function(CustomerState) then) =
      _$CustomerStateCopyWithImpl<$Res, CustomerState>;
}

/// @nodoc
class _$CustomerStateCopyWithImpl<$Res, $Val extends CustomerState>
    implements $CustomerStateCopyWith<$Res> {
  _$CustomerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CustomerStateLoadingImplCopyWith<$Res> {
  factory _$$CustomerStateLoadingImplCopyWith(_$CustomerStateLoadingImpl value,
          $Res Function(_$CustomerStateLoadingImpl) then) =
      __$$CustomerStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CustomerStateLoadingImplCopyWithImpl<$Res>
    extends _$CustomerStateCopyWithImpl<$Res, _$CustomerStateLoadingImpl>
    implements _$$CustomerStateLoadingImplCopyWith<$Res> {
  __$$CustomerStateLoadingImplCopyWithImpl(_$CustomerStateLoadingImpl _value,
      $Res Function(_$CustomerStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CustomerStateLoadingImpl implements CustomerStateLoading {
  const _$CustomerStateLoadingImpl();

  @override
  String toString() {
    return 'CustomerState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orderSold) loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orderSold)? loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orderSold)? loaded,
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
    required TResult Function(CustomerStateLoading value) loading,
    required TResult Function(CustomerStateLoaded value) loaded,
    required TResult Function(CustomerStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomerStateLoading value)? loading,
    TResult? Function(CustomerStateLoaded value)? loaded,
    TResult? Function(CustomerStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomerStateLoading value)? loading,
    TResult Function(CustomerStateLoaded value)? loaded,
    TResult Function(CustomerStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CustomerStateLoading implements CustomerState {
  const factory CustomerStateLoading() = _$CustomerStateLoadingImpl;
}

/// @nodoc
abstract class _$$CustomerStateLoadedImplCopyWith<$Res> {
  factory _$$CustomerStateLoadedImplCopyWith(_$CustomerStateLoadedImpl value,
          $Res Function(_$CustomerStateLoadedImpl) then) =
      __$$CustomerStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrderModel> orderSold});
}

/// @nodoc
class __$$CustomerStateLoadedImplCopyWithImpl<$Res>
    extends _$CustomerStateCopyWithImpl<$Res, _$CustomerStateLoadedImpl>
    implements _$$CustomerStateLoadedImplCopyWith<$Res> {
  __$$CustomerStateLoadedImplCopyWithImpl(_$CustomerStateLoadedImpl _value,
      $Res Function(_$CustomerStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderSold = null,
  }) {
    return _then(_$CustomerStateLoadedImpl(
      null == orderSold
          ? _value._orderSold
          : orderSold // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
    ));
  }
}

/// @nodoc

class _$CustomerStateLoadedImpl implements CustomerStateLoaded {
  const _$CustomerStateLoadedImpl(final List<OrderModel> orderSold)
      : _orderSold = orderSold;

  final List<OrderModel> _orderSold;
  @override
  List<OrderModel> get orderSold {
    if (_orderSold is EqualUnmodifiableListView) return _orderSold;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderSold);
  }

  @override
  String toString() {
    return 'CustomerState.loaded(orderSold: $orderSold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerStateLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._orderSold, _orderSold));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orderSold));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerStateLoadedImplCopyWith<_$CustomerStateLoadedImpl> get copyWith =>
      __$$CustomerStateLoadedImplCopyWithImpl<_$CustomerStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orderSold) loaded,
    required TResult Function() error,
  }) {
    return loaded(orderSold);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orderSold)? loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(orderSold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orderSold)? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(orderSold);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomerStateLoading value) loading,
    required TResult Function(CustomerStateLoaded value) loaded,
    required TResult Function(CustomerStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomerStateLoading value)? loading,
    TResult? Function(CustomerStateLoaded value)? loaded,
    TResult? Function(CustomerStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomerStateLoading value)? loading,
    TResult Function(CustomerStateLoaded value)? loaded,
    TResult Function(CustomerStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CustomerStateLoaded implements CustomerState {
  const factory CustomerStateLoaded(final List<OrderModel> orderSold) =
      _$CustomerStateLoadedImpl;

  List<OrderModel> get orderSold;
  @JsonKey(ignore: true)
  _$$CustomerStateLoadedImplCopyWith<_$CustomerStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomerStateErrorImplCopyWith<$Res> {
  factory _$$CustomerStateErrorImplCopyWith(_$CustomerStateErrorImpl value,
          $Res Function(_$CustomerStateErrorImpl) then) =
      __$$CustomerStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CustomerStateErrorImplCopyWithImpl<$Res>
    extends _$CustomerStateCopyWithImpl<$Res, _$CustomerStateErrorImpl>
    implements _$$CustomerStateErrorImplCopyWith<$Res> {
  __$$CustomerStateErrorImplCopyWithImpl(_$CustomerStateErrorImpl _value,
      $Res Function(_$CustomerStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CustomerStateErrorImpl implements CustomerStateError {
  const _$CustomerStateErrorImpl();

  @override
  String toString() {
    return 'CustomerState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CustomerStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orderSold) loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orderSold)? loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orderSold)? loaded,
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
    required TResult Function(CustomerStateLoading value) loading,
    required TResult Function(CustomerStateLoaded value) loaded,
    required TResult Function(CustomerStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomerStateLoading value)? loading,
    TResult? Function(CustomerStateLoaded value)? loaded,
    TResult? Function(CustomerStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomerStateLoading value)? loading,
    TResult Function(CustomerStateLoaded value)? loaded,
    TResult Function(CustomerStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CustomerStateError implements CustomerState {
  const factory CustomerStateError() = _$CustomerStateErrorImpl;
}
