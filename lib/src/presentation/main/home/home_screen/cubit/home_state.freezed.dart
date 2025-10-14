// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeStateInitial value)?  initial,TResult Function( HomeStateLoading value)?  loading,TResult Function( HomeStatecategoryLoading value)?  categoryLoading,TResult Function( HomeStateLoaded value)?  loaded,TResult Function( HomeStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeStateInitial() when initial != null:
return initial(_that);case HomeStateLoading() when loading != null:
return loading(_that);case HomeStatecategoryLoading() when categoryLoading != null:
return categoryLoading(_that);case HomeStateLoaded() when loaded != null:
return loaded(_that);case HomeStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeStateInitial value)  initial,required TResult Function( HomeStateLoading value)  loading,required TResult Function( HomeStatecategoryLoading value)  categoryLoading,required TResult Function( HomeStateLoaded value)  loaded,required TResult Function( HomeStateError value)  error,}){
final _that = this;
switch (_that) {
case HomeStateInitial():
return initial(_that);case HomeStateLoading():
return loading(_that);case HomeStatecategoryLoading():
return categoryLoading(_that);case HomeStateLoaded():
return loaded(_that);case HomeStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeStateInitial value)?  initial,TResult? Function( HomeStateLoading value)?  loading,TResult? Function( HomeStatecategoryLoading value)?  categoryLoading,TResult? Function( HomeStateLoaded value)?  loaded,TResult? Function( HomeStateError value)?  error,}){
final _that = this;
switch (_that) {
case HomeStateInitial() when initial != null:
return initial(_that);case HomeStateLoading() when loading != null:
return loading(_that);case HomeStatecategoryLoading() when categoryLoading != null:
return categoryLoading(_that);case HomeStateLoaded() when loaded != null:
return loaded(_that);case HomeStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CategoryModel>? location)?  categoryLoading,TResult Function( String banner,  List<CategoryModel> category,  List<CategoryModel> location,  List<ProductModel> recent,  List<ProductModel> company,  bool isRefreshLoader,  bool isPaginating)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeStateInitial() when initial != null:
return initial();case HomeStateLoading() when loading != null:
return loading();case HomeStatecategoryLoading() when categoryLoading != null:
return categoryLoading(_that.location);case HomeStateLoaded() when loaded != null:
return loaded(_that.banner,_that.category,_that.location,_that.recent,_that.company,_that.isRefreshLoader,_that.isPaginating);case HomeStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CategoryModel>? location)  categoryLoading,required TResult Function( String banner,  List<CategoryModel> category,  List<CategoryModel> location,  List<ProductModel> recent,  List<ProductModel> company,  bool isRefreshLoader,  bool isPaginating)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case HomeStateInitial():
return initial();case HomeStateLoading():
return loading();case HomeStatecategoryLoading():
return categoryLoading(_that.location);case HomeStateLoaded():
return loaded(_that.banner,_that.category,_that.location,_that.recent,_that.company,_that.isRefreshLoader,_that.isPaginating);case HomeStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CategoryModel>? location)?  categoryLoading,TResult? Function( String banner,  List<CategoryModel> category,  List<CategoryModel> location,  List<ProductModel> recent,  List<ProductModel> company,  bool isRefreshLoader,  bool isPaginating)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case HomeStateInitial() when initial != null:
return initial();case HomeStateLoading() when loading != null:
return loading();case HomeStatecategoryLoading() when categoryLoading != null:
return categoryLoading(_that.location);case HomeStateLoaded() when loaded != null:
return loaded(_that.banner,_that.category,_that.location,_that.recent,_that.company,_that.isRefreshLoader,_that.isPaginating);case HomeStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class HomeStateInitial implements HomeState {
  const HomeStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class HomeStateLoading implements HomeState {
  const HomeStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.loading()';
}


}




/// @nodoc


class HomeStatecategoryLoading implements HomeState {
  const HomeStatecategoryLoading(final  List<CategoryModel>? location): _location = location;
  

 final  List<CategoryModel>? _location;
 List<CategoryModel>? get location {
  final value = _location;
  if (value == null) return null;
  if (_location is EqualUnmodifiableListView) return _location;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStatecategoryLoadingCopyWith<HomeStatecategoryLoading> get copyWith => _$HomeStatecategoryLoadingCopyWithImpl<HomeStatecategoryLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStatecategoryLoading&&const DeepCollectionEquality().equals(other._location, _location));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_location));

@override
String toString() {
  return 'HomeState.categoryLoading(location: $location)';
}


}

/// @nodoc
abstract mixin class $HomeStatecategoryLoadingCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeStatecategoryLoadingCopyWith(HomeStatecategoryLoading value, $Res Function(HomeStatecategoryLoading) _then) = _$HomeStatecategoryLoadingCopyWithImpl;
@useResult
$Res call({
 List<CategoryModel>? location
});




}
/// @nodoc
class _$HomeStatecategoryLoadingCopyWithImpl<$Res>
    implements $HomeStatecategoryLoadingCopyWith<$Res> {
  _$HomeStatecategoryLoadingCopyWithImpl(this._self, this._then);

  final HomeStatecategoryLoading _self;
  final $Res Function(HomeStatecategoryLoading) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = freezed,}) {
  return _then(HomeStatecategoryLoading(
freezed == location ? _self._location : location // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>?,
  ));
}


}

/// @nodoc


class HomeStateLoaded implements HomeState {
  const HomeStateLoaded(this.banner, final  List<CategoryModel> category, final  List<CategoryModel> location, final  List<ProductModel> recent, final  List<ProductModel> company, this.isRefreshLoader, this.isPaginating): _category = category,_location = location,_recent = recent,_company = company;
  

 final  String banner;
 final  List<CategoryModel> _category;
 List<CategoryModel> get category {
  if (_category is EqualUnmodifiableListView) return _category;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_category);
}

 final  List<CategoryModel> _location;
 List<CategoryModel> get location {
  if (_location is EqualUnmodifiableListView) return _location;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_location);
}

 final  List<ProductModel> _recent;
 List<ProductModel> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

 final  List<ProductModel> _company;
 List<ProductModel> get company {
  if (_company is EqualUnmodifiableListView) return _company;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_company);
}

 final  bool isRefreshLoader;
 final  bool isPaginating;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateLoadedCopyWith<HomeStateLoaded> get copyWith => _$HomeStateLoadedCopyWithImpl<HomeStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStateLoaded&&(identical(other.banner, banner) || other.banner == banner)&&const DeepCollectionEquality().equals(other._category, _category)&&const DeepCollectionEquality().equals(other._location, _location)&&const DeepCollectionEquality().equals(other._recent, _recent)&&const DeepCollectionEquality().equals(other._company, _company)&&(identical(other.isRefreshLoader, isRefreshLoader) || other.isRefreshLoader == isRefreshLoader)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating));
}


@override
int get hashCode => Object.hash(runtimeType,banner,const DeepCollectionEquality().hash(_category),const DeepCollectionEquality().hash(_location),const DeepCollectionEquality().hash(_recent),const DeepCollectionEquality().hash(_company),isRefreshLoader,isPaginating);

@override
String toString() {
  return 'HomeState.loaded(banner: $banner, category: $category, location: $location, recent: $recent, company: $company, isRefreshLoader: $isRefreshLoader, isPaginating: $isPaginating)';
}


}

/// @nodoc
abstract mixin class $HomeStateLoadedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeStateLoadedCopyWith(HomeStateLoaded value, $Res Function(HomeStateLoaded) _then) = _$HomeStateLoadedCopyWithImpl;
@useResult
$Res call({
 String banner, List<CategoryModel> category, List<CategoryModel> location, List<ProductModel> recent, List<ProductModel> company, bool isRefreshLoader, bool isPaginating
});




}
/// @nodoc
class _$HomeStateLoadedCopyWithImpl<$Res>
    implements $HomeStateLoadedCopyWith<$Res> {
  _$HomeStateLoadedCopyWithImpl(this._self, this._then);

  final HomeStateLoaded _self;
  final $Res Function(HomeStateLoaded) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? banner = null,Object? category = null,Object? location = null,Object? recent = null,Object? company = null,Object? isRefreshLoader = null,Object? isPaginating = null,}) {
  return _then(HomeStateLoaded(
null == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as String,null == category ? _self._category : category // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,null == location ? _self._location : location // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,null == company ? _self._company : company // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,null == isRefreshLoader ? _self.isRefreshLoader : isRefreshLoader // ignore: cast_nullable_to_non_nullable
as bool,null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class HomeStateError implements HomeState {
  const HomeStateError(this.error);
  

 final  String error;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateErrorCopyWith<HomeStateError> get copyWith => _$HomeStateErrorCopyWithImpl<HomeStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'HomeState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $HomeStateErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeStateErrorCopyWith(HomeStateError value, $Res Function(HomeStateError) _then) = _$HomeStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$HomeStateErrorCopyWithImpl<$Res>
    implements $HomeStateErrorCopyWith<$Res> {
  _$HomeStateErrorCopyWithImpl(this._self, this._then);

  final HomeStateError _self;
  final $Res Function(HomeStateError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(HomeStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
