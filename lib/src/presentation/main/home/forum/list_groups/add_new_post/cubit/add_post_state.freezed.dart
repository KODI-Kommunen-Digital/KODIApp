// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_post_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddPostState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPostState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPostState()';
}


}

/// @nodoc
class $AddPostStateCopyWith<$Res>  {
$AddPostStateCopyWith(AddPostState _, $Res Function(AddPostState) __);
}


/// Adds pattern-matching-related methods to [AddPostState].
extension AddPostStatePatterns on AddPostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddPostLoading value)?  loading,TResult Function( AddPostLoaded value)?  loaded,TResult Function( AddPostError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddPostLoading() when loading != null:
return loading(_that);case AddPostLoaded() when loaded != null:
return loaded(_that);case AddPostError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddPostLoading value)  loading,required TResult Function( AddPostLoaded value)  loaded,required TResult Function( AddPostError value)  error,}){
final _that = this;
switch (_that) {
case AddPostLoading():
return loading(_that);case AddPostLoaded():
return loaded(_that);case AddPostError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddPostLoading value)?  loading,TResult? Function( AddPostLoaded value)?  loaded,TResult? Function( AddPostError value)?  error,}){
final _that = this;
switch (_that) {
case AddPostLoading() when loading != null:
return loading(_that);case AddPostLoaded() when loaded != null:
return loaded(_that);case AddPostError() when error != null:
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
case AddPostLoading() when loading != null:
return loading();case AddPostLoaded() when loaded != null:
return loaded();case AddPostError() when error != null:
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
case AddPostLoading():
return loading();case AddPostLoaded():
return loaded();case AddPostError():
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
case AddPostLoading() when loading != null:
return loading();case AddPostLoaded() when loaded != null:
return loaded();case AddPostError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class AddPostLoading implements AddPostState {
  const AddPostLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPostLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPostState.loading()';
}


}




/// @nodoc


class AddPostLoaded implements AddPostState {
  const AddPostLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPostLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPostState.loaded()';
}


}




/// @nodoc


class AddPostError implements AddPostState {
  const AddPostError(this.error);
  

 final  String error;

/// Create a copy of AddPostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddPostErrorCopyWith<AddPostError> get copyWith => _$AddPostErrorCopyWithImpl<AddPostError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPostError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AddPostState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $AddPostErrorCopyWith<$Res> implements $AddPostStateCopyWith<$Res> {
  factory $AddPostErrorCopyWith(AddPostError value, $Res Function(AddPostError) _then) = _$AddPostErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$AddPostErrorCopyWithImpl<$Res>
    implements $AddPostErrorCopyWith<$Res> {
  _$AddPostErrorCopyWithImpl(this._self, this._then);

  final AddPostError _self;
  final $Res Function(AddPostError) _then;

/// Create a copy of AddPostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(AddPostError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
