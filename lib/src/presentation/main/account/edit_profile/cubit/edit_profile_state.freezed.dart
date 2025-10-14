// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState()';
}


}

/// @nodoc
class $EditProfileStateCopyWith<$Res>  {
$EditProfileStateCopyWith(EditProfileState _, $Res Function(EditProfileState) __);
}


/// Adds pattern-matching-related methods to [EditProfileState].
extension EditProfileStatePatterns on EditProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EditProfileStateLoading value)?  loading,TResult Function( EditProfileStateLoaded value)?  loaded,TResult Function( EditProfileStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EditProfileStateLoading() when loading != null:
return loading(_that);case EditProfileStateLoaded() when loaded != null:
return loaded(_that);case EditProfileStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EditProfileStateLoading value)  loading,required TResult Function( EditProfileStateLoaded value)  loaded,required TResult Function( EditProfileStateError value)  error,}){
final _that = this;
switch (_that) {
case EditProfileStateLoading():
return loading(_that);case EditProfileStateLoaded():
return loaded(_that);case EditProfileStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EditProfileStateLoading value)?  loading,TResult? Function( EditProfileStateLoaded value)?  loaded,TResult? Function( EditProfileStateError value)?  error,}){
final _that = this;
switch (_that) {
case EditProfileStateLoading() when loading != null:
return loading(_that);case EditProfileStateLoaded() when loaded != null:
return loaded(_that);case EditProfileStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  loaded,TResult Function()?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EditProfileStateLoading() when loading != null:
return loading();case EditProfileStateLoaded() when loaded != null:
return loaded();case EditProfileStateError() when error != null:
return error();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  loaded,required TResult Function()  error,}) {final _that = this;
switch (_that) {
case EditProfileStateLoading():
return loading();case EditProfileStateLoaded():
return loaded();case EditProfileStateError():
return error();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function()?  error,}) {final _that = this;
switch (_that) {
case EditProfileStateLoading() when loading != null:
return loading();case EditProfileStateLoaded() when loaded != null:
return loaded();case EditProfileStateError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class EditProfileStateLoading implements EditProfileState {
  const EditProfileStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState.loading()';
}


}




/// @nodoc


class EditProfileStateLoaded implements EditProfileState {
  const EditProfileStateLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileStateLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState.loaded()';
}


}




/// @nodoc


class EditProfileStateError implements EditProfileState {
  const EditProfileStateError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileStateError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState.error()';
}


}




// dart format on
