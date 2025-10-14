// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WishListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishListState()';
}


}

/// @nodoc
class $WishListStateCopyWith<$Res>  {
$WishListStateCopyWith(WishListState _, $Res Function(WishListState) __);
}


/// Adds pattern-matching-related methods to [WishListState].
extension WishListStatePatterns on WishListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WishListInitial value)?  initial,TResult Function( WishListLoading value)?  loading,TResult Function( WishListLoaded value)?  loaded,TResult Function( WishListError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WishListInitial() when initial != null:
return initial(_that);case WishListLoading() when loading != null:
return loading(_that);case WishListLoaded() when loaded != null:
return loaded(_that);case WishListError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WishListInitial value)  initial,required TResult Function( WishListLoading value)  loading,required TResult Function( WishListLoaded value)  loaded,required TResult Function( WishListError value)  error,}){
final _that = this;
switch (_that) {
case WishListInitial():
return initial(_that);case WishListLoading():
return loading(_that);case WishListLoaded():
return loaded(_that);case WishListError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WishListInitial value)?  initial,TResult? Function( WishListLoading value)?  loading,TResult? Function( WishListLoaded value)?  loaded,TResult? Function( WishListError value)?  error,}){
final _that = this;
switch (_that) {
case WishListInitial() when initial != null:
return initial(_that);case WishListLoading() when loading != null:
return loading(_that);case WishListLoaded() when loaded != null:
return loaded(_that);case WishListError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<FavoriteDetailsModel> favorites)?  loaded,TResult Function( String errorMessage)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WishListInitial() when initial != null:
return initial();case WishListLoading() when loading != null:
return loading();case WishListLoaded() when loaded != null:
return loaded(_that.favorites);case WishListError() when error != null:
return error(_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<FavoriteDetailsModel> favorites)  loaded,required TResult Function( String errorMessage)  error,}) {final _that = this;
switch (_that) {
case WishListInitial():
return initial();case WishListLoading():
return loading();case WishListLoaded():
return loaded(_that.favorites);case WishListError():
return error(_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<FavoriteDetailsModel> favorites)?  loaded,TResult? Function( String errorMessage)?  error,}) {final _that = this;
switch (_that) {
case WishListInitial() when initial != null:
return initial();case WishListLoading() when loading != null:
return loading();case WishListLoaded() when loaded != null:
return loaded(_that.favorites);case WishListError() when error != null:
return error(_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class WishListInitial implements WishListState {
  const WishListInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishListInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishListState.initial()';
}


}




/// @nodoc


class WishListLoading implements WishListState {
  const WishListLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishListLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WishListState.loading()';
}


}




/// @nodoc


class WishListLoaded implements WishListState {
  const WishListLoaded(final  List<FavoriteDetailsModel> favorites): _favorites = favorites;
  

 final  List<FavoriteDetailsModel> _favorites;
 List<FavoriteDetailsModel> get favorites {
  if (_favorites is EqualUnmodifiableListView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favorites);
}


/// Create a copy of WishListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishListLoadedCopyWith<WishListLoaded> get copyWith => _$WishListLoadedCopyWithImpl<WishListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishListLoaded&&const DeepCollectionEquality().equals(other._favorites, _favorites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favorites));

@override
String toString() {
  return 'WishListState.loaded(favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $WishListLoadedCopyWith<$Res> implements $WishListStateCopyWith<$Res> {
  factory $WishListLoadedCopyWith(WishListLoaded value, $Res Function(WishListLoaded) _then) = _$WishListLoadedCopyWithImpl;
@useResult
$Res call({
 List<FavoriteDetailsModel> favorites
});




}
/// @nodoc
class _$WishListLoadedCopyWithImpl<$Res>
    implements $WishListLoadedCopyWith<$Res> {
  _$WishListLoadedCopyWithImpl(this._self, this._then);

  final WishListLoaded _self;
  final $Res Function(WishListLoaded) _then;

/// Create a copy of WishListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? favorites = null,}) {
  return _then(WishListLoaded(
null == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<FavoriteDetailsModel>,
  ));
}


}

/// @nodoc


class WishListError implements WishListState {
  const WishListError(this.errorMessage);
  

 final  String errorMessage;

/// Create a copy of WishListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishListErrorCopyWith<WishListError> get copyWith => _$WishListErrorCopyWithImpl<WishListError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishListError&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'WishListState.error(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $WishListErrorCopyWith<$Res> implements $WishListStateCopyWith<$Res> {
  factory $WishListErrorCopyWith(WishListError value, $Res Function(WishListError) _then) = _$WishListErrorCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class _$WishListErrorCopyWithImpl<$Res>
    implements $WishListErrorCopyWith<$Res> {
  _$WishListErrorCopyWithImpl(this._self, this._then);

  final WishListError _self;
  final $Res Function(WishListError) _then;

/// Create a copy of WishListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(WishListError(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
