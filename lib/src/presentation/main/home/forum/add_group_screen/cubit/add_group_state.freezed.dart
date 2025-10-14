// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddGroupState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddGroupState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddGroupState()';
}


}

/// @nodoc
class $AddGroupStateCopyWith<$Res>  {
$AddGroupStateCopyWith(AddGroupState _, $Res Function(AddGroupState) __);
}


/// Adds pattern-matching-related methods to [AddGroupState].
extension AddGroupStatePatterns on AddGroupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddGroupLoading value)?  loading,TResult Function( AddGroupLoaded value)?  loaded,TResult Function( AddGroupError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddGroupLoading() when loading != null:
return loading(_that);case AddGroupLoaded() when loaded != null:
return loaded(_that);case AddGroupError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddGroupLoading value)  loading,required TResult Function( AddGroupLoaded value)  loaded,required TResult Function( AddGroupError value)  error,}){
final _that = this;
switch (_that) {
case AddGroupLoading():
return loading(_that);case AddGroupLoaded():
return loaded(_that);case AddGroupError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddGroupLoading value)?  loading,TResult? Function( AddGroupLoaded value)?  loaded,TResult? Function( AddGroupError value)?  error,}){
final _that = this;
switch (_that) {
case AddGroupLoading() when loading != null:
return loading(_that);case AddGroupLoaded() when loaded != null:
return loaded(_that);case AddGroupError() when error != null:
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
case AddGroupLoading() when loading != null:
return loading();case AddGroupLoaded() when loaded != null:
return loaded();case AddGroupError() when error != null:
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
case AddGroupLoading():
return loading();case AddGroupLoaded():
return loaded();case AddGroupError():
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
case AddGroupLoading() when loading != null:
return loading();case AddGroupLoaded() when loaded != null:
return loaded();case AddGroupError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class AddGroupLoading implements AddGroupState {
  const AddGroupLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddGroupLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddGroupState.loading()';
}


}




/// @nodoc


class AddGroupLoaded implements AddGroupState {
  const AddGroupLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddGroupLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddGroupState.loaded()';
}


}




/// @nodoc


class AddGroupError implements AddGroupState {
  const AddGroupError(this.error);
  

 final  String error;

/// Create a copy of AddGroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddGroupErrorCopyWith<AddGroupError> get copyWith => _$AddGroupErrorCopyWithImpl<AddGroupError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddGroupError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AddGroupState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $AddGroupErrorCopyWith<$Res> implements $AddGroupStateCopyWith<$Res> {
  factory $AddGroupErrorCopyWith(AddGroupError value, $Res Function(AddGroupError) _then) = _$AddGroupErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$AddGroupErrorCopyWithImpl<$Res>
    implements $AddGroupErrorCopyWith<$Res> {
  _$AddGroupErrorCopyWithImpl(this._self, this._then);

  final AddGroupError _self;
  final $Res Function(AddGroupError) _then;

/// Create a copy of AddGroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(AddGroupError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
