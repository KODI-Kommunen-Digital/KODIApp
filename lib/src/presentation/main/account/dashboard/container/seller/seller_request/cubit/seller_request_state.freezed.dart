// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SellerRequestState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CategoryModel> cities,
            List<StoreModel> stores, int? selectedCity)
        loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CategoryModel> cities, List<StoreModel> stores,
            int? selectedCity)?
        loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CategoryModel> cities, List<StoreModel> stores,
            int? selectedCity)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SellerRequestStateLoading value) loading,
    required TResult Function(SellerRequestStateLoaded value) loaded,
    required TResult Function(SellerRequestStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerRequestStateLoading value)? loading,
    TResult? Function(SellerRequestStateLoaded value)? loaded,
    TResult? Function(SellerRequestStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerRequestStateLoading value)? loading,
    TResult Function(SellerRequestStateLoaded value)? loaded,
    TResult Function(SellerRequestStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellerRequestStateCopyWith<$Res> {
  factory $SellerRequestStateCopyWith(
          SellerRequestState value, $Res Function(SellerRequestState) then) =
      _$SellerRequestStateCopyWithImpl<$Res, SellerRequestState>;
}

/// @nodoc
class _$SellerRequestStateCopyWithImpl<$Res, $Val extends SellerRequestState>
    implements $SellerRequestStateCopyWith<$Res> {
  _$SellerRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SellerRequestStateLoadingImplCopyWith<$Res> {
  factory _$$SellerRequestStateLoadingImplCopyWith(
          _$SellerRequestStateLoadingImpl value,
          $Res Function(_$SellerRequestStateLoadingImpl) then) =
      __$$SellerRequestStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SellerRequestStateLoadingImplCopyWithImpl<$Res>
    extends _$SellerRequestStateCopyWithImpl<$Res,
        _$SellerRequestStateLoadingImpl>
    implements _$$SellerRequestStateLoadingImplCopyWith<$Res> {
  __$$SellerRequestStateLoadingImplCopyWithImpl(
      _$SellerRequestStateLoadingImpl _value,
      $Res Function(_$SellerRequestStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SellerRequestStateLoadingImpl implements SellerRequestStateLoading {
  const _$SellerRequestStateLoadingImpl();

  @override
  String toString() {
    return 'SellerRequestState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellerRequestStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CategoryModel> cities,
            List<StoreModel> stores, int? selectedCity)
        loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CategoryModel> cities, List<StoreModel> stores,
            int? selectedCity)?
        loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CategoryModel> cities, List<StoreModel> stores,
            int? selectedCity)?
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
    required TResult Function(SellerRequestStateLoading value) loading,
    required TResult Function(SellerRequestStateLoaded value) loaded,
    required TResult Function(SellerRequestStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerRequestStateLoading value)? loading,
    TResult? Function(SellerRequestStateLoaded value)? loaded,
    TResult? Function(SellerRequestStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerRequestStateLoading value)? loading,
    TResult Function(SellerRequestStateLoaded value)? loaded,
    TResult Function(SellerRequestStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SellerRequestStateLoading implements SellerRequestState {
  const factory SellerRequestStateLoading() = _$SellerRequestStateLoadingImpl;
}

/// @nodoc
abstract class _$$SellerRequestStateLoadedImplCopyWith<$Res> {
  factory _$$SellerRequestStateLoadedImplCopyWith(
          _$SellerRequestStateLoadedImpl value,
          $Res Function(_$SellerRequestStateLoadedImpl) then) =
      __$$SellerRequestStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<CategoryModel> cities, List<StoreModel> stores, int? selectedCity});
}

/// @nodoc
class __$$SellerRequestStateLoadedImplCopyWithImpl<$Res>
    extends _$SellerRequestStateCopyWithImpl<$Res,
        _$SellerRequestStateLoadedImpl>
    implements _$$SellerRequestStateLoadedImplCopyWith<$Res> {
  __$$SellerRequestStateLoadedImplCopyWithImpl(
      _$SellerRequestStateLoadedImpl _value,
      $Res Function(_$SellerRequestStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cities = null,
    Object? stores = null,
    Object? selectedCity = freezed,
  }) {
    return _then(_$SellerRequestStateLoadedImpl(
      null == cities
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      null == stores
          ? _value._stores
          : stores // ignore: cast_nullable_to_non_nullable
              as List<StoreModel>,
      freezed == selectedCity
          ? _value.selectedCity
          : selectedCity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SellerRequestStateLoadedImpl implements SellerRequestStateLoaded {
  const _$SellerRequestStateLoadedImpl(final List<CategoryModel> cities,
      final List<StoreModel> stores, this.selectedCity)
      : _cities = cities,
        _stores = stores;

  final List<CategoryModel> _cities;
  @override
  List<CategoryModel> get cities {
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cities);
  }

  final List<StoreModel> _stores;
  @override
  List<StoreModel> get stores {
    if (_stores is EqualUnmodifiableListView) return _stores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stores);
  }

  @override
  final int? selectedCity;

  @override
  String toString() {
    return 'SellerRequestState.loaded(cities: $cities, stores: $stores, selectedCity: $selectedCity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellerRequestStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._cities, _cities) &&
            const DeepCollectionEquality().equals(other._stores, _stores) &&
            (identical(other.selectedCity, selectedCity) ||
                other.selectedCity == selectedCity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cities),
      const DeepCollectionEquality().hash(_stores),
      selectedCity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SellerRequestStateLoadedImplCopyWith<_$SellerRequestStateLoadedImpl>
      get copyWith => __$$SellerRequestStateLoadedImplCopyWithImpl<
          _$SellerRequestStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CategoryModel> cities,
            List<StoreModel> stores, int? selectedCity)
        loaded,
    required TResult Function() error,
  }) {
    return loaded(cities, stores, selectedCity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CategoryModel> cities, List<StoreModel> stores,
            int? selectedCity)?
        loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(cities, stores, selectedCity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CategoryModel> cities, List<StoreModel> stores,
            int? selectedCity)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cities, stores, selectedCity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SellerRequestStateLoading value) loading,
    required TResult Function(SellerRequestStateLoaded value) loaded,
    required TResult Function(SellerRequestStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerRequestStateLoading value)? loading,
    TResult? Function(SellerRequestStateLoaded value)? loaded,
    TResult? Function(SellerRequestStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerRequestStateLoading value)? loading,
    TResult Function(SellerRequestStateLoaded value)? loaded,
    TResult Function(SellerRequestStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SellerRequestStateLoaded implements SellerRequestState {
  const factory SellerRequestStateLoaded(
      final List<CategoryModel> cities,
      final List<StoreModel> stores,
      final int? selectedCity) = _$SellerRequestStateLoadedImpl;

  List<CategoryModel> get cities;
  List<StoreModel> get stores;
  int? get selectedCity;
  @JsonKey(ignore: true)
  _$$SellerRequestStateLoadedImplCopyWith<_$SellerRequestStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SellerRequestStateErrorImplCopyWith<$Res> {
  factory _$$SellerRequestStateErrorImplCopyWith(
          _$SellerRequestStateErrorImpl value,
          $Res Function(_$SellerRequestStateErrorImpl) then) =
      __$$SellerRequestStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SellerRequestStateErrorImplCopyWithImpl<$Res>
    extends _$SellerRequestStateCopyWithImpl<$Res,
        _$SellerRequestStateErrorImpl>
    implements _$$SellerRequestStateErrorImplCopyWith<$Res> {
  __$$SellerRequestStateErrorImplCopyWithImpl(
      _$SellerRequestStateErrorImpl _value,
      $Res Function(_$SellerRequestStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SellerRequestStateErrorImpl implements SellerRequestStateError {
  const _$SellerRequestStateErrorImpl();

  @override
  String toString() {
    return 'SellerRequestState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellerRequestStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CategoryModel> cities,
            List<StoreModel> stores, int? selectedCity)
        loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CategoryModel> cities, List<StoreModel> stores,
            int? selectedCity)?
        loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CategoryModel> cities, List<StoreModel> stores,
            int? selectedCity)?
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
    required TResult Function(SellerRequestStateLoading value) loading,
    required TResult Function(SellerRequestStateLoaded value) loaded,
    required TResult Function(SellerRequestStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SellerRequestStateLoading value)? loading,
    TResult? Function(SellerRequestStateLoaded value)? loaded,
    TResult? Function(SellerRequestStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SellerRequestStateLoading value)? loading,
    TResult Function(SellerRequestStateLoaded value)? loaded,
    TResult Function(SellerRequestStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SellerRequestStateError implements SellerRequestState {
  const factory SellerRequestStateError() = _$SellerRequestStateErrorImpl;
}
