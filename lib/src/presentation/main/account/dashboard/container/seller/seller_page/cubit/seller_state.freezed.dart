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
    required TResult Function(List<CartItemModel> orderSold) loadedOrders,
    required TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)
        loadedProducts,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult? Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SellerStateLoading value) loading,
    required TResult Function(SellerStateLoadedOrders value) loadedOrders,
    required TResult Function(SellerStateLoadedProducts value) loadedProducts,
    required TResult Function(SellerStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult? Function(SellerStateLoadedProducts value)? loadedProducts,
    TResult? Function(SellerStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult Function(SellerStateLoadedProducts value)? loadedProducts,
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
    required TResult Function(List<CartItemModel> orderSold) loadedOrders,
    required TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)
        loadedProducts,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult? Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
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
    required TResult Function(SellerStateLoadedOrders value) loadedOrders,
    required TResult Function(SellerStateLoadedProducts value) loadedProducts,
    required TResult Function(SellerStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult? Function(SellerStateLoadedProducts value)? loadedProducts,
    TResult? Function(SellerStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult Function(SellerStateLoadedProducts value)? loadedProducts,
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
abstract class _$$SellerStateLoadedOrdersImplCopyWith<$Res> {
  factory _$$SellerStateLoadedOrdersImplCopyWith(
          _$SellerStateLoadedOrdersImpl value,
          $Res Function(_$SellerStateLoadedOrdersImpl) then) =
      __$$SellerStateLoadedOrdersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CartItemModel> orderSold});
}

/// @nodoc
class __$$SellerStateLoadedOrdersImplCopyWithImpl<$Res>
    extends _$SellerStateCopyWithImpl<$Res, _$SellerStateLoadedOrdersImpl>
    implements _$$SellerStateLoadedOrdersImplCopyWith<$Res> {
  __$$SellerStateLoadedOrdersImplCopyWithImpl(
      _$SellerStateLoadedOrdersImpl _value,
      $Res Function(_$SellerStateLoadedOrdersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderSold = null,
  }) {
    return _then(_$SellerStateLoadedOrdersImpl(
      null == orderSold
          ? _value._orderSold
          : orderSold // ignore: cast_nullable_to_non_nullable
              as List<CartItemModel>,
    ));
  }
}

/// @nodoc

class _$SellerStateLoadedOrdersImpl implements SellerStateLoadedOrders {
  const _$SellerStateLoadedOrdersImpl(final List<CartItemModel> orderSold)
      : _orderSold = orderSold;

  final List<CartItemModel> _orderSold;
  @override
  List<CartItemModel> get orderSold {
    if (_orderSold is EqualUnmodifiableListView) return _orderSold;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderSold);
  }

  @override
  String toString() {
    return 'SellerState.loadedOrders(orderSold: $orderSold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellerStateLoadedOrdersImpl &&
            const DeepCollectionEquality()
                .equals(other._orderSold, _orderSold));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orderSold));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SellerStateLoadedOrdersImplCopyWith<_$SellerStateLoadedOrdersImpl>
      get copyWith => __$$SellerStateLoadedOrdersImplCopyWithImpl<
          _$SellerStateLoadedOrdersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CartItemModel> orderSold) loadedOrders,
    required TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)
        loadedProducts,
    required TResult Function() error,
  }) {
    return loadedOrders(orderSold);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult? Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
    TResult? Function()? error,
  }) {
    return loadedOrders?.call(orderSold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loadedOrders != null) {
      return loadedOrders(orderSold);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SellerStateLoading value) loading,
    required TResult Function(SellerStateLoadedOrders value) loadedOrders,
    required TResult Function(SellerStateLoadedProducts value) loadedProducts,
    required TResult Function(SellerStateError value) error,
  }) {
    return loadedOrders(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult? Function(SellerStateLoadedProducts value)? loadedProducts,
    TResult? Function(SellerStateError value)? error,
  }) {
    return loadedOrders?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult Function(SellerStateLoadedProducts value)? loadedProducts,
    TResult Function(SellerStateError value)? error,
    required TResult orElse(),
  }) {
    if (loadedOrders != null) {
      return loadedOrders(this);
    }
    return orElse();
  }
}

abstract class SellerStateLoadedOrders implements SellerState {
  const factory SellerStateLoadedOrders(final List<CartItemModel> orderSold) =
      _$SellerStateLoadedOrdersImpl;

  List<CartItemModel> get orderSold;
  @JsonKey(ignore: true)
  _$$SellerStateLoadedOrdersImplCopyWith<_$SellerStateLoadedOrdersImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SellerStateLoadedProductsImplCopyWith<$Res> {
  factory _$$SellerStateLoadedProductsImplCopyWith(
          _$SellerStateLoadedProductsImpl value,
          $Res Function(_$SellerStateLoadedProductsImpl) then) =
      __$$SellerStateLoadedProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ContainerProductModel>? products,
      List<StoreModel> stores,
      StoreModel? selectedStore});
}

/// @nodoc
class __$$SellerStateLoadedProductsImplCopyWithImpl<$Res>
    extends _$SellerStateCopyWithImpl<$Res, _$SellerStateLoadedProductsImpl>
    implements _$$SellerStateLoadedProductsImplCopyWith<$Res> {
  __$$SellerStateLoadedProductsImplCopyWithImpl(
      _$SellerStateLoadedProductsImpl _value,
      $Res Function(_$SellerStateLoadedProductsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = freezed,
    Object? stores = null,
    Object? selectedStore = freezed,
  }) {
    return _then(_$SellerStateLoadedProductsImpl(
      freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ContainerProductModel>?,
      null == stores
          ? _value._stores
          : stores // ignore: cast_nullable_to_non_nullable
              as List<StoreModel>,
      freezed == selectedStore
          ? _value.selectedStore
          : selectedStore // ignore: cast_nullable_to_non_nullable
              as StoreModel?,
    ));
  }
}

/// @nodoc

class _$SellerStateLoadedProductsImpl implements SellerStateLoadedProducts {
  const _$SellerStateLoadedProductsImpl(
      final List<ContainerProductModel>? products,
      final List<StoreModel> stores,
      this.selectedStore)
      : _products = products,
        _stores = stores;

  final List<ContainerProductModel>? _products;
  @override
  List<ContainerProductModel>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<StoreModel> _stores;
  @override
  List<StoreModel> get stores {
    if (_stores is EqualUnmodifiableListView) return _stores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stores);
  }

  @override
  final StoreModel? selectedStore;

  @override
  String toString() {
    return 'SellerState.loadedProducts(products: $products, stores: $stores, selectedStore: $selectedStore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellerStateLoadedProductsImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._stores, _stores) &&
            (identical(other.selectedStore, selectedStore) ||
                other.selectedStore == selectedStore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_stores),
      selectedStore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SellerStateLoadedProductsImplCopyWith<_$SellerStateLoadedProductsImpl>
      get copyWith => __$$SellerStateLoadedProductsImplCopyWithImpl<
          _$SellerStateLoadedProductsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CartItemModel> orderSold) loadedOrders,
    required TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)
        loadedProducts,
    required TResult Function() error,
  }) {
    return loadedProducts(products, stores, selectedStore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult? Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
    TResult? Function()? error,
  }) {
    return loadedProducts?.call(products, stores, selectedStore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loadedProducts != null) {
      return loadedProducts(products, stores, selectedStore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SellerStateLoading value) loading,
    required TResult Function(SellerStateLoadedOrders value) loadedOrders,
    required TResult Function(SellerStateLoadedProducts value) loadedProducts,
    required TResult Function(SellerStateError value) error,
  }) {
    return loadedProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult? Function(SellerStateLoadedProducts value)? loadedProducts,
    TResult? Function(SellerStateError value)? error,
  }) {
    return loadedProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult Function(SellerStateLoadedProducts value)? loadedProducts,
    TResult Function(SellerStateError value)? error,
    required TResult orElse(),
  }) {
    if (loadedProducts != null) {
      return loadedProducts(this);
    }
    return orElse();
  }
}

abstract class SellerStateLoadedProducts implements SellerState {
  const factory SellerStateLoadedProducts(
      final List<ContainerProductModel>? products,
      final List<StoreModel> stores,
      final StoreModel? selectedStore) = _$SellerStateLoadedProductsImpl;

  List<ContainerProductModel>? get products;
  List<StoreModel> get stores;
  StoreModel? get selectedStore;
  @JsonKey(ignore: true)
  _$$SellerStateLoadedProductsImplCopyWith<_$SellerStateLoadedProductsImpl>
      get copyWith => throw _privateConstructorUsedError;
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
    required TResult Function(List<CartItemModel> orderSold) loadedOrders,
    required TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)
        loadedProducts,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult? Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItemModel> orderSold)? loadedOrders,
    TResult Function(List<ContainerProductModel>? products,
            List<StoreModel> stores, StoreModel? selectedStore)?
        loadedProducts,
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
    required TResult Function(SellerStateLoadedOrders value) loadedOrders,
    required TResult Function(SellerStateLoadedProducts value) loadedProducts,
    required TResult Function(SellerStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerStateLoading value)? loading,
    TResult? Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult? Function(SellerStateLoadedProducts value)? loadedProducts,
    TResult? Function(SellerStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerStateLoading value)? loading,
    TResult Function(SellerStateLoadedOrders value)? loadedOrders,
    TResult Function(SellerStateLoadedProducts value)? loadedProducts,
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
