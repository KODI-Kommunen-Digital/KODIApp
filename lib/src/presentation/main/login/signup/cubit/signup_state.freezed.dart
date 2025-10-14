// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState()';
}


}

/// @nodoc
class $SignUpStateCopyWith<$Res>  {
$SignUpStateCopyWith(SignUpState _, $Res Function(SignUpState) __);
}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignUpStateLoading value)?  loading,TResult Function( SignUpStateLoaded value)?  loaded,TResult Function( SignUpStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignUpStateLoading() when loading != null:
return loading(_that);case SignUpStateLoaded() when loaded != null:
return loaded(_that);case SignUpStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignUpStateLoading value)  loading,required TResult Function( SignUpStateLoaded value)  loaded,required TResult Function( SignUpStateError value)  error,}){
final _that = this;
switch (_that) {
case SignUpStateLoading():
return loading(_that);case SignUpStateLoaded():
return loaded(_that);case SignUpStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignUpStateLoading value)?  loading,TResult? Function( SignUpStateLoaded value)?  loaded,TResult? Function( SignUpStateError value)?  error,}){
final _that = this;
switch (_that) {
case SignUpStateLoading() when loading != null:
return loading(_that);case SignUpStateLoaded() when loaded != null:
return loaded(_that);case SignUpStateError() when error != null:
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
case SignUpStateLoading() when loading != null:
return loading();case SignUpStateLoaded() when loaded != null:
return loaded();case SignUpStateError() when error != null:
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
case SignUpStateLoading():
return loading();case SignUpStateLoaded():
return loaded();case SignUpStateError():
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
case SignUpStateLoading() when loading != null:
return loading();case SignUpStateLoaded() when loaded != null:
return loaded();case SignUpStateError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class SignUpStateLoading implements SignUpState {
  const SignUpStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState.loading()';
}


}




/// @nodoc


class SignUpStateLoaded implements SignUpState {
  const SignUpStateLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpStateLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState.loaded()';
}


}




/// @nodoc


class SignUpStateError implements SignUpState {
  const SignUpStateError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpStateError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState.error()';
}


}




// dart format on
