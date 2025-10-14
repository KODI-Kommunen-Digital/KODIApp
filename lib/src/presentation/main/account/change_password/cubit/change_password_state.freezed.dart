// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangePasswordState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangePasswordState()';
}


}

/// @nodoc
class $ChangePasswordStateCopyWith<$Res>  {
$ChangePasswordStateCopyWith(ChangePasswordState _, $Res Function(ChangePasswordState) __);
}


/// Adds pattern-matching-related methods to [ChangePasswordState].
extension ChangePasswordStatePatterns on ChangePasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChangePasswordStateLoading value)?  loading,TResult Function( ChangePasswordStateLoaded value)?  loaded,TResult Function( ChangePasswordStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChangePasswordStateLoading() when loading != null:
return loading(_that);case ChangePasswordStateLoaded() when loaded != null:
return loaded(_that);case ChangePasswordStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChangePasswordStateLoading value)  loading,required TResult Function( ChangePasswordStateLoaded value)  loaded,required TResult Function( ChangePasswordStateError value)  error,}){
final _that = this;
switch (_that) {
case ChangePasswordStateLoading():
return loading(_that);case ChangePasswordStateLoaded():
return loaded(_that);case ChangePasswordStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChangePasswordStateLoading value)?  loading,TResult? Function( ChangePasswordStateLoaded value)?  loaded,TResult? Function( ChangePasswordStateError value)?  error,}){
final _that = this;
switch (_that) {
case ChangePasswordStateLoading() when loading != null:
return loading(_that);case ChangePasswordStateLoaded() when loaded != null:
return loaded(_that);case ChangePasswordStateError() when error != null:
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
case ChangePasswordStateLoading() when loading != null:
return loading();case ChangePasswordStateLoaded() when loaded != null:
return loaded();case ChangePasswordStateError() when error != null:
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
case ChangePasswordStateLoading():
return loading();case ChangePasswordStateLoaded():
return loaded();case ChangePasswordStateError():
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
case ChangePasswordStateLoading() when loading != null:
return loading();case ChangePasswordStateLoaded() when loaded != null:
return loaded();case ChangePasswordStateError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class ChangePasswordStateLoading implements ChangePasswordState {
  const ChangePasswordStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangePasswordState.loading()';
}


}




/// @nodoc


class ChangePasswordStateLoaded implements ChangePasswordState {
  const ChangePasswordStateLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordStateLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangePasswordState.loaded()';
}


}




/// @nodoc


class ChangePasswordStateError implements ChangePasswordState {
  const ChangePasswordStateError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordStateError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangePasswordState.error()';
}


}




// dart format on
