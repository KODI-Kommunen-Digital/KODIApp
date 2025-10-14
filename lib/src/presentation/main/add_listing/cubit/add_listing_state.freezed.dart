// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_listing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddListingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddListingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddListingState()';
}


}

/// @nodoc
class $AddListingStateCopyWith<$Res>  {
$AddListingStateCopyWith(AddListingState _, $Res Function(AddListingState) __);
}


/// Adds pattern-matching-related methods to [AddListingState].
extension AddListingStatePatterns on AddListingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddListingLoading value)?  loading,TResult Function( AddListingLoaded value)?  loaded,TResult Function( AddListingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddListingLoading() when loading != null:
return loading(_that);case AddListingLoaded() when loaded != null:
return loaded(_that);case AddListingError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddListingLoading value)  loading,required TResult Function( AddListingLoaded value)  loaded,required TResult Function( AddListingError value)  error,}){
final _that = this;
switch (_that) {
case AddListingLoading():
return loading(_that);case AddListingLoaded():
return loaded(_that);case AddListingError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddListingLoading value)?  loading,TResult? Function( AddListingLoaded value)?  loaded,TResult? Function( AddListingError value)?  error,}){
final _that = this;
switch (_that) {
case AddListingLoading() when loading != null:
return loading(_that);case AddListingLoaded() when loaded != null:
return loaded(_that);case AddListingError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddListingLoading() when loading != null:
return loading();case AddListingLoaded() when loaded != null:
return loaded();case AddListingError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case AddListingLoading():
return loading();case AddListingLoaded():
return loaded();case AddListingError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case AddListingLoading() when loading != null:
return loading();case AddListingLoaded() when loaded != null:
return loaded();case AddListingError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class AddListingLoading implements AddListingState {
  const AddListingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddListingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddListingState.loading()';
}


}




/// @nodoc


class AddListingLoaded implements AddListingState {
  const AddListingLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddListingLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddListingState.loaded()';
}


}




/// @nodoc


class AddListingError implements AddListingState {
  const AddListingError(this.error);
  

 final  String error;

/// Create a copy of AddListingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddListingErrorCopyWith<AddListingError> get copyWith => _$AddListingErrorCopyWithImpl<AddListingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddListingError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AddListingState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $AddListingErrorCopyWith<$Res> implements $AddListingStateCopyWith<$Res> {
  factory $AddListingErrorCopyWith(AddListingError value, $Res Function(AddListingError) _then) = _$AddListingErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$AddListingErrorCopyWithImpl<$Res>
    implements $AddListingErrorCopyWith<$Res> {
  _$AddListingErrorCopyWithImpl(this._self, this._then);

  final AddListingError _self;
  final $Res Function(AddListingError) _then;

/// Create a copy of AddListingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(AddListingError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
