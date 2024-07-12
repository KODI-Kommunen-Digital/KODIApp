// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SellerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)
        loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)?
        loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SellerStateLoading value) loading,
    required TResult Function(SellerStateLoaded value) loaded,
    required TResult Function(SellerStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoaded value)? loaded,
    TResult? Function(SellerStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoaded value)? loaded,
    TResult Function(SellerStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellerStateCopyWith<$Res> {
  factory $SellerStateCopyWith(
          SellerState value, $Res Function(SellerState) then) =
      _$SellerStateCopyWithImpl<$Res, SellerState>;
}

/// @nodoc
class _$SellerStateCopyWithImpl<$Res, $Val extends SellerState>
    implements $SellerStateCopyWith<$Res> {
  _$SellerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SellerStateLoadingImplCopyWith<$Res> {
  factory _$$SellerStateLoadingImplCopyWith(_$SellerStateLoadingImpl value,
          $Res Function(_$SellerStateLoadingImpl) then) =
      __$$SellerStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SellerStateLoadingImplCopyWithImpl<$Res>
    extends _$SellerStateCopyWithImpl<$Res, _$SellerStateLoadingImpl>
    implements _$$SellerStateLoadingImplCopyWith<$Res> {
  __$$SellerStateLoadingImplCopyWithImpl(_$SellerStateLoadingImpl _value,
      $Res Function(_$SellerStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SellerStateLoadingImpl implements SellerStateLoading {
  const _$SellerStateLoadingImpl();

  @override
  String toString() {
    return 'SellerState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SellerStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)
        loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)?
        loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)?
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
    required TResult Function(SellerStateLoading value) loading,
    required TResult Function(SellerStateLoaded value) loaded,
    required TResult Function(SellerStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoaded value)? loaded,
    TResult? Function(SellerStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoaded value)? loaded,
    TResult Function(SellerStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SellerStateLoading implements SellerState {
  const factory SellerStateLoading() = _$SellerStateLoadingImpl;
}

/// @nodoc
abstract class _$$SellerStateLoadedImplCopyWith<$Res> {
  factory _$$SellerStateLoadedImplCopyWith(_$SellerStateLoadedImpl value,
          $Res Function(_$SellerStateLoadedImpl) then) =
      __$$SellerStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<OrderModel> orderSold, List<ProductRequestModel> productRequests});
}

/// @nodoc
class __$$SellerStateLoadedImplCopyWithImpl<$Res>
    extends _$SellerStateCopyWithImpl<$Res, _$SellerStateLoadedImpl>
    implements _$$SellerStateLoadedImplCopyWith<$Res> {
  __$$SellerStateLoadedImplCopyWithImpl(_$SellerStateLoadedImpl _value,
      $Res Function(_$SellerStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderSold = null,
    Object? productRequests = null,
  }) {
    return _then(_$SellerStateLoadedImpl(
      null == orderSold
          ? _value._orderSold
          : orderSold // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      null == productRequests
          ? _value._productRequests
          : productRequests // ignore: cast_nullable_to_non_nullable
              as List<ProductRequestModel>,
    ));
  }
}

/// @nodoc

class _$SellerStateLoadedImpl implements SellerStateLoaded {
  const _$SellerStateLoadedImpl(final List<OrderModel> orderSold,
      final List<ProductRequestModel> productRequests)
      : _orderSold = orderSold,
        _productRequests = productRequests;

  final List<OrderModel> _orderSold;
  @override
  List<OrderModel> get orderSold {
    if (_orderSold is EqualUnmodifiableListView) return _orderSold;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderSold);
  }

  final List<ProductRequestModel> _productRequests;
  @override
  List<ProductRequestModel> get productRequests {
    if (_productRequests is EqualUnmodifiableListView) return _productRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productRequests);
  }

  @override
  String toString() {
    return 'SellerState.loaded(orderSold: $orderSold, productRequests: $productRequests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellerStateLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._orderSold, _orderSold) &&
            const DeepCollectionEquality()
                .equals(other._productRequests, _productRequests));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_orderSold),
      const DeepCollectionEquality().hash(_productRequests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SellerStateLoadedImplCopyWith<_$SellerStateLoadedImpl> get copyWith =>
      __$$SellerStateLoadedImplCopyWithImpl<_$SellerStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)
        loaded,
    required TResult Function() error,
  }) {
    return loaded(orderSold, productRequests);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)?
        loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(orderSold, productRequests);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(orderSold, productRequests);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SellerStateLoading value) loading,
    required TResult Function(SellerStateLoaded value) loaded,
    required TResult Function(SellerStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoaded value)? loaded,
    TResult? Function(SellerStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoaded value)? loaded,
    TResult Function(SellerStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SellerStateLoaded implements SellerState {
  const factory SellerStateLoaded(final List<OrderModel> orderSold,
          final List<ProductRequestModel> productRequests) =
      _$SellerStateLoadedImpl;

  List<OrderModel> get orderSold;
  List<ProductRequestModel> get productRequests;
  @JsonKey(ignore: true)
  _$$SellerStateLoadedImplCopyWith<_$SellerStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SellerStateErrorImplCopyWith<$Res> {
  factory _$$SellerStateErrorImplCopyWith(_$SellerStateErrorImpl value,
          $Res Function(_$SellerStateErrorImpl) then) =
      __$$SellerStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SellerStateErrorImplCopyWithImpl<$Res>
    extends _$SellerStateCopyWithImpl<$Res, _$SellerStateErrorImpl>
    implements _$$SellerStateErrorImplCopyWith<$Res> {
  __$$SellerStateErrorImplCopyWithImpl(_$SellerStateErrorImpl _value,
      $Res Function(_$SellerStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SellerStateErrorImpl implements SellerStateError {
  const _$SellerStateErrorImpl();

  @override
  String toString() {
    return 'SellerState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SellerStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)
        loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)?
        loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<OrderModel> orderSold,
            List<ProductRequestModel> productRequests)?
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
    required TResult Function(SellerStateLoading value) loading,
    required TResult Function(SellerStateLoaded value) loaded,
    required TResult Function(SellerStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoaded value)? loaded,
    TResult? Function(SellerStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoaded value)? loaded,
    TResult Function(SellerStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SellerStateError implements SellerState {
  const factory SellerStateError() = _$SellerStateErrorImpl;
}
