// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_listings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AllListingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllListingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllListingsState()';
}


}

/// @nodoc
class $AllListingsStateCopyWith<$Res>  {
$AllListingsStateCopyWith(AllListingsState _, $Res Function(AllListingsState) __);
}


/// Adds pattern-matching-related methods to [AllListingsState].
extension AllListingsStatePatterns on AllListingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AllListingsStateInitial value)?  initial,TResult Function( AllListingsStateLoading value)?  loading,TResult Function( AllListingsStateLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AllListingsStateInitial() when initial != null:
return initial(_that);case AllListingsStateLoading() when loading != null:
return loading(_that);case AllListingsStateLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AllListingsStateInitial value)  initial,required TResult Function( AllListingsStateLoading value)  loading,required TResult Function( AllListingsStateLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case AllListingsStateInitial():
return initial(_that);case AllListingsStateLoading():
return loading(_that);case AllListingsStateLoaded():
return loaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AllListingsStateInitial value)?  initial,TResult? Function( AllListingsStateLoading value)?  loading,TResult? Function( AllListingsStateLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case AllListingsStateInitial() when initial != null:
return initial(_that);case AllListingsStateLoading() when loading != null:
return loading(_that);case AllListingsStateLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ProductModel> recent,  int currentFilter,  int currentCityFilter)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AllListingsStateInitial() when initial != null:
return initial();case AllListingsStateLoading() when loading != null:
return loading();case AllListingsStateLoaded() when loaded != null:
return loaded(_that.recent,_that.currentFilter,_that.currentCityFilter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ProductModel> recent,  int currentFilter,  int currentCityFilter)  loaded,}) {final _that = this;
switch (_that) {
case AllListingsStateInitial():
return initial();case AllListingsStateLoading():
return loading();case AllListingsStateLoaded():
return loaded(_that.recent,_that.currentFilter,_that.currentCityFilter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ProductModel> recent,  int currentFilter,  int currentCityFilter)?  loaded,}) {final _that = this;
switch (_that) {
case AllListingsStateInitial() when initial != null:
return initial();case AllListingsStateLoading() when loading != null:
return loading();case AllListingsStateLoaded() when loaded != null:
return loaded(_that.recent,_that.currentFilter,_that.currentCityFilter);case _:
  return null;

}
}

}

/// @nodoc


class AllListingsStateInitial implements AllListingsState {
  const AllListingsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllListingsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllListingsState.initial()';
}


}




/// @nodoc


class AllListingsStateLoading implements AllListingsState {
  const AllListingsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllListingsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllListingsState.loading()';
}


}




/// @nodoc


class AllListingsStateLoaded implements AllListingsState {
  const AllListingsStateLoaded(final  List<ProductModel> recent, this.currentFilter, this.currentCityFilter): _recent = recent;
  

 final  List<ProductModel> _recent;
 List<ProductModel> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

 final  int currentFilter;
 final  int currentCityFilter;

/// Create a copy of AllListingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllListingsStateLoadedCopyWith<AllListingsStateLoaded> get copyWith => _$AllListingsStateLoadedCopyWithImpl<AllListingsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllListingsStateLoaded&&const DeepCollectionEquality().equals(other._recent, _recent)&&(identical(other.currentFilter, currentFilter) || other.currentFilter == currentFilter)&&(identical(other.currentCityFilter, currentCityFilter) || other.currentCityFilter == currentCityFilter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recent),currentFilter,currentCityFilter);

@override
String toString() {
  return 'AllListingsState.loaded(recent: $recent, currentFilter: $currentFilter, currentCityFilter: $currentCityFilter)';
}


}

/// @nodoc
abstract mixin class $AllListingsStateLoadedCopyWith<$Res> implements $AllListingsStateCopyWith<$Res> {
  factory $AllListingsStateLoadedCopyWith(AllListingsStateLoaded value, $Res Function(AllListingsStateLoaded) _then) = _$AllListingsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> recent, int currentFilter, int currentCityFilter
});




}
/// @nodoc
class _$AllListingsStateLoadedCopyWithImpl<$Res>
    implements $AllListingsStateLoadedCopyWith<$Res> {
  _$AllListingsStateLoadedCopyWithImpl(this._self, this._then);

  final AllListingsStateLoaded _self;
  final $Res Function(AllListingsStateLoaded) _then;

/// Create a copy of AllListingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recent = null,Object? currentFilter = null,Object? currentCityFilter = null,}) {
  return _then(AllListingsStateLoaded(
null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,null == currentFilter ? _self.currentFilter : currentFilter // ignore: cast_nullable_to_non_nullable
as int,null == currentCityFilter ? _self.currentCityFilter : currentCityFilter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
