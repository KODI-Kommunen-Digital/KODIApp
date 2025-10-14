// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductDetailState()';
}


}

/// @nodoc
class $ProductDetailStateCopyWith<$Res>  {
$ProductDetailStateCopyWith(ProductDetailState _, $Res Function(ProductDetailState) __);
}


/// Adds pattern-matching-related methods to [ProductDetailState].
extension ProductDetailStatePatterns on ProductDetailState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductDetailInitial value)?  initial,TResult Function( ProductDetailLoading value)?  loading,TResult Function( ProductDetailLoaded value)?  loaded,TResult Function( ProductDetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductDetailInitial() when initial != null:
return initial(_that);case ProductDetailLoading() when loading != null:
return loading(_that);case ProductDetailLoaded() when loaded != null:
return loaded(_that);case ProductDetailError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductDetailInitial value)  initial,required TResult Function( ProductDetailLoading value)  loading,required TResult Function( ProductDetailLoaded value)  loaded,required TResult Function( ProductDetailError value)  error,}){
final _that = this;
switch (_that) {
case ProductDetailInitial():
return initial(_that);case ProductDetailLoading():
return loading(_that);case ProductDetailLoaded():
return loaded(_that);case ProductDetailError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductDetailInitial value)?  initial,TResult? Function( ProductDetailLoading value)?  loading,TResult? Function( ProductDetailLoaded value)?  loaded,TResult? Function( ProductDetailError value)?  error,}){
final _that = this;
switch (_that) {
case ProductDetailInitial() when initial != null:
return initial(_that);case ProductDetailLoading() when loading != null:
return loading(_that);case ProductDetailLoaded() when loaded != null:
return loaded(_that);case ProductDetailError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ProductModel product,  List<FavoriteModel>? favoritesList,  UserModel? userDetail,  bool isLoggedIn,  bool isDarkMode)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductDetailInitial() when initial != null:
return initial();case ProductDetailLoading() when loading != null:
return loading();case ProductDetailLoaded() when loaded != null:
return loaded(_that.product,_that.favoritesList,_that.userDetail,_that.isLoggedIn,_that.isDarkMode);case ProductDetailError() when error != null:
return error(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ProductModel product,  List<FavoriteModel>? favoritesList,  UserModel? userDetail,  bool isLoggedIn,  bool isDarkMode)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case ProductDetailInitial():
return initial();case ProductDetailLoading():
return loading();case ProductDetailLoaded():
return loaded(_that.product,_that.favoritesList,_that.userDetail,_that.isLoggedIn,_that.isDarkMode);case ProductDetailError():
return error(_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ProductModel product,  List<FavoriteModel>? favoritesList,  UserModel? userDetail,  bool isLoggedIn,  bool isDarkMode)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case ProductDetailInitial() when initial != null:
return initial();case ProductDetailLoading() when loading != null:
return loading();case ProductDetailLoaded() when loaded != null:
return loaded(_that.product,_that.favoritesList,_that.userDetail,_that.isLoggedIn,_that.isDarkMode);case ProductDetailError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ProductDetailInitial implements ProductDetailState {
  const ProductDetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductDetailState.initial()';
}


}




/// @nodoc


class ProductDetailLoading implements ProductDetailState {
  const ProductDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductDetailState.loading()';
}


}




/// @nodoc


class ProductDetailLoaded implements ProductDetailState {
  const ProductDetailLoaded(this.product, final  List<FavoriteModel>? favoritesList, this.userDetail, this.isLoggedIn, this.isDarkMode): _favoritesList = favoritesList;
  

 final  ProductModel product;
 final  List<FavoriteModel>? _favoritesList;
 List<FavoriteModel>? get favoritesList {
  final value = _favoritesList;
  if (value == null) return null;
  if (_favoritesList is EqualUnmodifiableListView) return _favoritesList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  UserModel? userDetail;
 final  bool isLoggedIn;
 final  bool isDarkMode;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailLoadedCopyWith<ProductDetailLoaded> get copyWith => _$ProductDetailLoadedCopyWithImpl<ProductDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailLoaded&&(identical(other.product, product) || other.product == product)&&const DeepCollectionEquality().equals(other._favoritesList, _favoritesList)&&(identical(other.userDetail, userDetail) || other.userDetail == userDetail)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode));
}


@override
int get hashCode => Object.hash(runtimeType,product,const DeepCollectionEquality().hash(_favoritesList),userDetail,isLoggedIn,isDarkMode);

@override
String toString() {
  return 'ProductDetailState.loaded(product: $product, favoritesList: $favoritesList, userDetail: $userDetail, isLoggedIn: $isLoggedIn, isDarkMode: $isDarkMode)';
}


}

/// @nodoc
abstract mixin class $ProductDetailLoadedCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailLoadedCopyWith(ProductDetailLoaded value, $Res Function(ProductDetailLoaded) _then) = _$ProductDetailLoadedCopyWithImpl;
@useResult
$Res call({
 ProductModel product, List<FavoriteModel>? favoritesList, UserModel? userDetail, bool isLoggedIn, bool isDarkMode
});




}
/// @nodoc
class _$ProductDetailLoadedCopyWithImpl<$Res>
    implements $ProductDetailLoadedCopyWith<$Res> {
  _$ProductDetailLoadedCopyWithImpl(this._self, this._then);

  final ProductDetailLoaded _self;
  final $Res Function(ProductDetailLoaded) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? favoritesList = freezed,Object? userDetail = freezed,Object? isLoggedIn = null,Object? isDarkMode = null,}) {
  return _then(ProductDetailLoaded(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductModel,freezed == favoritesList ? _self._favoritesList : favoritesList // ignore: cast_nullable_to_non_nullable
as List<FavoriteModel>?,freezed == userDetail ? _self.userDetail : userDetail // ignore: cast_nullable_to_non_nullable
as UserModel?,null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ProductDetailError implements ProductDetailState {
  const ProductDetailError(this.error);
  

 final  String error;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailErrorCopyWith<ProductDetailError> get copyWith => _$ProductDetailErrorCopyWithImpl<ProductDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ProductDetailState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ProductDetailErrorCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailErrorCopyWith(ProductDetailError value, $Res Function(ProductDetailError) _then) = _$ProductDetailErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ProductDetailErrorCopyWithImpl<$Res>
    implements $ProductDetailErrorCopyWith<$Res> {
  _$ProductDetailErrorCopyWithImpl(this._self, this._then);

  final ProductDetailError _self;
  final $Res Function(ProductDetailError) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ProductDetailError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
