// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_requests_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AllRequestsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllRequestsState()';
}


}

/// @nodoc
class $AllRequestsStateCopyWith<$Res>  {
$AllRequestsStateCopyWith(AllRequestsState _, $Res Function(AllRequestsState) __);
}


/// Adds pattern-matching-related methods to [AllRequestsState].
extension AllRequestsStatePatterns on AllRequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AllRequestsStateInitial value)?  initial,TResult Function( AllRequestsStateLoading value)?  loading,TResult Function( AllRequestsStateLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AllRequestsStateInitial() when initial != null:
return initial(_that);case AllRequestsStateLoading() when loading != null:
return loading(_that);case AllRequestsStateLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AllRequestsStateInitial value)  initial,required TResult Function( AllRequestsStateLoading value)  loading,required TResult Function( AllRequestsStateLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case AllRequestsStateInitial():
return initial(_that);case AllRequestsStateLoading():
return loading(_that);case AllRequestsStateLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AllRequestsStateInitial value)?  initial,TResult? Function( AllRequestsStateLoading value)?  loading,TResult? Function( AllRequestsStateLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case AllRequestsStateInitial() when initial != null:
return initial(_that);case AllRequestsStateLoading() when loading != null:
return loading(_that);case AllRequestsStateLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ProductModel> recent,  bool isRefreshLoader)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AllRequestsStateInitial() when initial != null:
return initial();case AllRequestsStateLoading() when loading != null:
return loading();case AllRequestsStateLoaded() when loaded != null:
return loaded(_that.recent,_that.isRefreshLoader);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ProductModel> recent,  bool isRefreshLoader)  loaded,}) {final _that = this;
switch (_that) {
case AllRequestsStateInitial():
return initial();case AllRequestsStateLoading():
return loading();case AllRequestsStateLoaded():
return loaded(_that.recent,_that.isRefreshLoader);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ProductModel> recent,  bool isRefreshLoader)?  loaded,}) {final _that = this;
switch (_that) {
case AllRequestsStateInitial() when initial != null:
return initial();case AllRequestsStateLoading() when loading != null:
return loading();case AllRequestsStateLoaded() when loaded != null:
return loaded(_that.recent,_that.isRefreshLoader);case _:
  return null;

}
}

}

/// @nodoc


class AllRequestsStateInitial implements AllRequestsState {
  const AllRequestsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllRequestsState.initial()';
}


}




/// @nodoc


class AllRequestsStateLoading implements AllRequestsState {
  const AllRequestsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllRequestsState.loading()';
}


}




/// @nodoc


class AllRequestsStateLoaded implements AllRequestsState {
  const AllRequestsStateLoaded(final  List<ProductModel> recent, this.isRefreshLoader): _recent = recent;
  

 final  List<ProductModel> _recent;
 List<ProductModel> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

 final  bool isRefreshLoader;

/// Create a copy of AllRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllRequestsStateLoadedCopyWith<AllRequestsStateLoaded> get copyWith => _$AllRequestsStateLoadedCopyWithImpl<AllRequestsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsStateLoaded&&const DeepCollectionEquality().equals(other._recent, _recent)&&(identical(other.isRefreshLoader, isRefreshLoader) || other.isRefreshLoader == isRefreshLoader));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recent),isRefreshLoader);

@override
String toString() {
  return 'AllRequestsState.loaded(recent: $recent, isRefreshLoader: $isRefreshLoader)';
}


}

/// @nodoc
abstract mixin class $AllRequestsStateLoadedCopyWith<$Res> implements $AllRequestsStateCopyWith<$Res> {
  factory $AllRequestsStateLoadedCopyWith(AllRequestsStateLoaded value, $Res Function(AllRequestsStateLoaded) _then) = _$AllRequestsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> recent, bool isRefreshLoader
});




}
/// @nodoc
class _$AllRequestsStateLoadedCopyWithImpl<$Res>
    implements $AllRequestsStateLoadedCopyWith<$Res> {
  _$AllRequestsStateLoadedCopyWithImpl(this._self, this._then);

  final AllRequestsStateLoaded _self;
  final $Res Function(AllRequestsStateLoaded) _then;

/// Create a copy of AllRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recent = null,Object? isRefreshLoader = null,}) {
  return _then(AllRequestsStateLoaded(
null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,null == isRefreshLoader ? _self.isRefreshLoader : isRefreshLoader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
