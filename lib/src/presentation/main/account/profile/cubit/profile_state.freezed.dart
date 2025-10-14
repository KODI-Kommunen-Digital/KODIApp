// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState()';
}


}

/// @nodoc
class $ProfileStateCopyWith<$Res>  {
$ProfileStateCopyWith(ProfileState _, $Res Function(ProfileState) __);
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileStateLoading value)?  loading,TResult Function( ProfileStateLoaded value)?  loaded,TResult Function( ProfileStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileStateLoading() when loading != null:
return loading(_that);case ProfileStateLoaded() when loaded != null:
return loaded(_that);case ProfileStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileStateLoading value)  loading,required TResult Function( ProfileStateLoaded value)  loaded,required TResult Function( ProfileStateError value)  error,}){
final _that = this;
switch (_that) {
case ProfileStateLoading():
return loading(_that);case ProfileStateLoaded():
return loaded(_that);case ProfileStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileStateLoading value)?  loading,TResult? Function( ProfileStateLoaded value)?  loaded,TResult? Function( ProfileStateError value)?  error,}){
final _that = this;
switch (_that) {
case ProfileStateLoading() when loading != null:
return loading(_that);case ProfileStateLoaded() when loaded != null:
return loaded(_that);case ProfileStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<ProductModel> userListings)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileStateLoading() when loading != null:
return loading();case ProfileStateLoaded() when loaded != null:
return loaded(_that.userListings);case ProfileStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<ProductModel> userListings)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case ProfileStateLoading():
return loading();case ProfileStateLoaded():
return loaded(_that.userListings);case ProfileStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<ProductModel> userListings)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case ProfileStateLoading() when loading != null:
return loading();case ProfileStateLoaded() when loaded != null:
return loaded(_that.userListings);case ProfileStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ProfileStateLoading implements ProfileState {
  const ProfileStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.loading()';
}


}




/// @nodoc


class ProfileStateLoaded implements ProfileState {
  const ProfileStateLoaded(final  List<ProductModel> userListings): _userListings = userListings;
  

 final  List<ProductModel> _userListings;
 List<ProductModel> get userListings {
  if (_userListings is EqualUnmodifiableListView) return _userListings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userListings);
}


/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateLoadedCopyWith<ProfileStateLoaded> get copyWith => _$ProfileStateLoadedCopyWithImpl<ProfileStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileStateLoaded&&const DeepCollectionEquality().equals(other._userListings, _userListings));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_userListings));

@override
String toString() {
  return 'ProfileState.loaded(userListings: $userListings)';
}


}

/// @nodoc
abstract mixin class $ProfileStateLoadedCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileStateLoadedCopyWith(ProfileStateLoaded value, $Res Function(ProfileStateLoaded) _then) = _$ProfileStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> userListings
});




}
/// @nodoc
class _$ProfileStateLoadedCopyWithImpl<$Res>
    implements $ProfileStateLoadedCopyWith<$Res> {
  _$ProfileStateLoadedCopyWithImpl(this._self, this._then);

  final ProfileStateLoaded _self;
  final $Res Function(ProfileStateLoaded) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userListings = null,}) {
  return _then(ProfileStateLoaded(
null == userListings ? _self._userListings : userListings // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,
  ));
}


}

/// @nodoc


class ProfileStateError implements ProfileState {
  const ProfileStateError(this.error);
  

 final  String error;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateErrorCopyWith<ProfileStateError> get copyWith => _$ProfileStateErrorCopyWithImpl<ProfileStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ProfileState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ProfileStateErrorCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileStateErrorCopyWith(ProfileStateError value, $Res Function(ProfileStateError) _then) = _$ProfileStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ProfileStateErrorCopyWithImpl<$Res>
    implements $ProfileStateErrorCopyWith<$Res> {
  _$ProfileStateErrorCopyWithImpl(this._self, this._then);

  final ProfileStateError _self;
  final $Res Function(ProfileStateError) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ProfileStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
