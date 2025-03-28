// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateProductState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)
        loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)?
        loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateProductStateLoading value) loading,
    required TResult Function(CreateProductStateLoaded value) loaded,
    required TResult Function(CreateProductStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateProductStateLoading value)? loading,
    TResult? Function(CreateProductStateLoaded value)? loaded,
    TResult? Function(CreateProductStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateProductStateLoading value)? loading,
    TResult Function(CreateProductStateLoaded value)? loaded,
    TResult Function(CreateProductStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateProductStateCopyWith<$Res> {
  factory $CreateProductStateCopyWith(
          CreateProductState value, $Res Function(CreateProductState) then) =
      _$CreateProductStateCopyWithImpl<$Res, CreateProductState>;
}

/// @nodoc
class _$CreateProductStateCopyWithImpl<$Res, $Val extends CreateProductState>
    implements $CreateProductStateCopyWith<$Res> {
  _$CreateProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CreateProductStateLoadingImplCopyWith<$Res> {
  factory _$$CreateProductStateLoadingImplCopyWith(
          _$CreateProductStateLoadingImpl value,
          $Res Function(_$CreateProductStateLoadingImpl) then) =
      __$$CreateProductStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateProductStateLoadingImplCopyWithImpl<$Res>
    extends _$CreateProductStateCopyWithImpl<$Res,
        _$CreateProductStateLoadingImpl>
    implements _$$CreateProductStateLoadingImplCopyWith<$Res> {
  __$$CreateProductStateLoadingImplCopyWithImpl(
      _$CreateProductStateLoadingImpl _value,
      $Res Function(_$CreateProductStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateProductStateLoadingImpl implements CreateProductStateLoading {
  const _$CreateProductStateLoadingImpl();

  @override
  String toString() {
    return 'CreateProductState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateProductStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)
        loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)?
        loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)?
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
    required TResult Function(CreateProductStateLoading value) loading,
    required TResult Function(CreateProductStateLoaded value) loaded,
    required TResult Function(CreateProductStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateProductStateLoading value)? loading,
    TResult? Function(CreateProductStateLoaded value)? loaded,
    TResult? Function(CreateProductStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateProductStateLoading value)? loading,
    TResult Function(CreateProductStateLoaded value)? loaded,
    TResult Function(CreateProductStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CreateProductStateLoading implements CreateProductState {
  const factory CreateProductStateLoading() = _$CreateProductStateLoadingImpl;
}

/// @nodoc
abstract class _$$CreateProductStateLoadedImplCopyWith<$Res> {
  factory _$$CreateProductStateLoadedImplCopyWith(
          _$CreateProductStateLoadedImpl value,
          $Res Function(_$CreateProductStateLoadedImpl) then) =
      __$$CreateProductStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<CategoryModel> cities,
      List<StoreModel> stores,
      int? selectedCity,
      List<CategoryModel> categories,
      List<CategoryModel> subCategories,
      Map<String, dynamic>? productDetails,
      StoreModel? selectedStore,
      CategoryModel? selectedCategory,
      CategoryModel? selectedSubCategory});
}

/// @nodoc
class __$$CreateProductStateLoadedImplCopyWithImpl<$Res>
    extends _$CreateProductStateCopyWithImpl<$Res,
        _$CreateProductStateLoadedImpl>
    implements _$$CreateProductStateLoadedImplCopyWith<$Res> {
  __$$CreateProductStateLoadedImplCopyWithImpl(
      _$CreateProductStateLoadedImpl _value,
      $Res Function(_$CreateProductStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cities = null,
    Object? stores = null,
    Object? selectedCity = freezed,
    Object? categories = null,
    Object? subCategories = null,
    Object? productDetails = freezed,
    Object? selectedStore = freezed,
    Object? selectedCategory = freezed,
    Object? selectedSubCategory = freezed,
  }) {
    return _then(_$CreateProductStateLoadedImpl(
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
      null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      null == subCategories
          ? _value._subCategories
          : subCategories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      freezed == productDetails
          ? _value._productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      freezed == selectedStore
          ? _value.selectedStore
          : selectedStore // ignore: cast_nullable_to_non_nullable
              as StoreModel?,
      freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      freezed == selectedSubCategory
          ? _value.selectedSubCategory
          : selectedSubCategory // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
    ));
  }
}

/// @nodoc

class _$CreateProductStateLoadedImpl implements CreateProductStateLoaded {
  const _$CreateProductStateLoadedImpl(
      final List<CategoryModel> cities,
      final List<StoreModel> stores,
      this.selectedCity,
      final List<CategoryModel> categories,
      final List<CategoryModel> subCategories,
      final Map<String, dynamic>? productDetails,
      this.selectedStore,
      this.selectedCategory,
      this.selectedSubCategory)
      : _cities = cities,
        _stores = stores,
        _categories = categories,
        _subCategories = subCategories,
        _productDetails = productDetails;

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
  final List<CategoryModel> _categories;
  @override
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<CategoryModel> _subCategories;
  @override
  List<CategoryModel> get subCategories {
    if (_subCategories is EqualUnmodifiableListView) return _subCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subCategories);
  }

  final Map<String, dynamic>? _productDetails;
  @override
  Map<String, dynamic>? get productDetails {
    final value = _productDetails;
    if (value == null) return null;
    if (_productDetails is EqualUnmodifiableMapView) return _productDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final StoreModel? selectedStore;
  @override
  final CategoryModel? selectedCategory;
  @override
  final CategoryModel? selectedSubCategory;

  @override
  String toString() {
    return 'CreateProductState.loaded(cities: $cities, stores: $stores, selectedCity: $selectedCity, categories: $categories, subCategories: $subCategories, productDetails: $productDetails, selectedStore: $selectedStore, selectedCategory: $selectedCategory, selectedSubCategory: $selectedSubCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateProductStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._cities, _cities) &&
            const DeepCollectionEquality().equals(other._stores, _stores) &&
            (identical(other.selectedCity, selectedCity) ||
                other.selectedCity == selectedCity) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._subCategories, _subCategories) &&
            const DeepCollectionEquality()
                .equals(other._productDetails, _productDetails) &&
            (identical(other.selectedStore, selectedStore) ||
                other.selectedStore == selectedStore) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.selectedSubCategory, selectedSubCategory) ||
                other.selectedSubCategory == selectedSubCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cities),
      const DeepCollectionEquality().hash(_stores),
      selectedCity,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_subCategories),
      const DeepCollectionEquality().hash(_productDetails),
      selectedStore,
      selectedCategory,
      selectedSubCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateProductStateLoadedImplCopyWith<_$CreateProductStateLoadedImpl>
      get copyWith => __$$CreateProductStateLoadedImplCopyWithImpl<
          _$CreateProductStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)
        loaded,
    required TResult Function() error,
  }) {
    return loaded(cities, stores, selectedCity, categories, subCategories,
        productDetails, selectedStore, selectedCategory, selectedSubCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)?
        loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(cities, stores, selectedCity, categories, subCategories,
        productDetails, selectedStore, selectedCategory, selectedSubCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cities, stores, selectedCity, categories, subCategories,
          productDetails, selectedStore, selectedCategory, selectedSubCategory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateProductStateLoading value) loading,
    required TResult Function(CreateProductStateLoaded value) loaded,
    required TResult Function(CreateProductStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateProductStateLoading value)? loading,
    TResult? Function(CreateProductStateLoaded value)? loaded,
    TResult? Function(CreateProductStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateProductStateLoading value)? loading,
    TResult Function(CreateProductStateLoaded value)? loaded,
    TResult Function(CreateProductStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CreateProductStateLoaded implements CreateProductState {
  const factory CreateProductStateLoaded(
          final List<CategoryModel> cities,
          final List<StoreModel> stores,
          final int? selectedCity,
          final List<CategoryModel> categories,
          final List<CategoryModel> subCategories,
          final Map<String, dynamic>? productDetails,
          final StoreModel? selectedStore,
          final CategoryModel? selectedCategory,
          final CategoryModel? selectedSubCategory) =
      _$CreateProductStateLoadedImpl;

  List<CategoryModel> get cities;
  List<StoreModel> get stores;
  int? get selectedCity;
  List<CategoryModel> get categories;
  List<CategoryModel> get subCategories;
  Map<String, dynamic>? get productDetails;
  StoreModel? get selectedStore;
  CategoryModel? get selectedCategory;
  CategoryModel? get selectedSubCategory;
  @JsonKey(ignore: true)
  _$$CreateProductStateLoadedImplCopyWith<_$CreateProductStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateProductStateErrorImplCopyWith<$Res> {
  factory _$$CreateProductStateErrorImplCopyWith(
          _$CreateProductStateErrorImpl value,
          $Res Function(_$CreateProductStateErrorImpl) then) =
      __$$CreateProductStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateProductStateErrorImplCopyWithImpl<$Res>
    extends _$CreateProductStateCopyWithImpl<$Res,
        _$CreateProductStateErrorImpl>
    implements _$$CreateProductStateErrorImplCopyWith<$Res> {
  __$$CreateProductStateErrorImplCopyWithImpl(
      _$CreateProductStateErrorImpl _value,
      $Res Function(_$CreateProductStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateProductStateErrorImpl implements CreateProductStateError {
  const _$CreateProductStateErrorImpl();

  @override
  String toString() {
    return 'CreateProductState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateProductStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)
        loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)?
        loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<CategoryModel> cities,
            List<StoreModel> stores,
            int? selectedCity,
            List<CategoryModel> categories,
            List<CategoryModel> subCategories,
            Map<String, dynamic>? productDetails,
            StoreModel? selectedStore,
            CategoryModel? selectedCategory,
            CategoryModel? selectedSubCategory)?
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
    required TResult Function(CreateProductStateLoading value) loading,
    required TResult Function(CreateProductStateLoaded value) loaded,
    required TResult Function(CreateProductStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateProductStateLoading value)? loading,
    TResult? Function(CreateProductStateLoaded value)? loaded,
    TResult? Function(CreateProductStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateProductStateLoading value)? loading,
    TResult Function(CreateProductStateLoaded value)? loaded,
    TResult Function(CreateProductStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CreateProductStateError implements CreateProductState {
  const factory CreateProductStateError() = _$CreateProductStateErrorImpl;
}
