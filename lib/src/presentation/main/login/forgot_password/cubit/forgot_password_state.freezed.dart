// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState()';
}


}

/// @nodoc
class $ForgotPasswordStateCopyWith<$Res>  {
$ForgotPasswordStateCopyWith(ForgotPasswordState _, $Res Function(ForgotPasswordState) __);
}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns on ForgotPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ForgotPasswordStateLoading value)?  loading,TResult Function( ForgotPasswordStateLoaded value)?  loaded,TResult Function( ForgotPasswordStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ForgotPasswordStateLoading() when loading != null:
return loading(_that);case ForgotPasswordStateLoaded() when loaded != null:
return loaded(_that);case ForgotPasswordStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ForgotPasswordStateLoading value)  loading,required TResult Function( ForgotPasswordStateLoaded value)  loaded,required TResult Function( ForgotPasswordStateError value)  error,}){
final _that = this;
switch (_that) {
case ForgotPasswordStateLoading():
return loading(_that);case ForgotPasswordStateLoaded():
return loaded(_that);case ForgotPasswordStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ForgotPasswordStateLoading value)?  loading,TResult? Function( ForgotPasswordStateLoaded value)?  loaded,TResult? Function( ForgotPasswordStateError value)?  error,}){
final _that = this;
switch (_that) {
case ForgotPasswordStateLoading() when loading != null:
return loading(_that);case ForgotPasswordStateLoaded() when loaded != null:
return loaded(_that);case ForgotPasswordStateError() when error != null:
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
case ForgotPasswordStateLoading() when loading != null:
return loading();case ForgotPasswordStateLoaded() when loaded != null:
return loaded();case ForgotPasswordStateError() when error != null:
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
case ForgotPasswordStateLoading():
return loading();case ForgotPasswordStateLoaded():
return loaded();case ForgotPasswordStateError():
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
case ForgotPasswordStateLoading() when loading != null:
return loading();case ForgotPasswordStateLoaded() when loaded != null:
return loaded();case ForgotPasswordStateError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class ForgotPasswordStateLoading implements ForgotPasswordState {
  const ForgotPasswordStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.loading()';
}


}




/// @nodoc


class ForgotPasswordStateLoaded implements ForgotPasswordState {
  const ForgotPasswordStateLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordStateLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.loaded()';
}


}




/// @nodoc


class ForgotPasswordStateError implements ForgotPasswordState {
  const ForgotPasswordStateError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordStateError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.error()';
}


}




// dart format on
