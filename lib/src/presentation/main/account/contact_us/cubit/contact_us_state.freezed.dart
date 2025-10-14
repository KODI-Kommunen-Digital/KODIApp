// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_us_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactUsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactUsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactUsState()';
}


}

/// @nodoc
class $ContactUsStateCopyWith<$Res>  {
$ContactUsStateCopyWith(ContactUsState _, $Res Function(ContactUsState) __);
}


/// Adds pattern-matching-related methods to [ContactUsState].
extension ContactUsStatePatterns on ContactUsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ContactUsStateLoading value)?  loading,TResult Function( ContactUsStateLoaded value)?  loaded,TResult Function( ContactUsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ContactUsStateLoading() when loading != null:
return loading(_that);case ContactUsStateLoaded() when loaded != null:
return loaded(_that);case ContactUsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ContactUsStateLoading value)  loading,required TResult Function( ContactUsStateLoaded value)  loaded,required TResult Function( ContactUsStateError value)  error,}){
final _that = this;
switch (_that) {
case ContactUsStateLoading():
return loading(_that);case ContactUsStateLoaded():
return loaded(_that);case ContactUsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ContactUsStateLoading value)?  loading,TResult? Function( ContactUsStateLoaded value)?  loaded,TResult? Function( ContactUsStateError value)?  error,}){
final _that = this;
switch (_that) {
case ContactUsStateLoading() when loading != null:
return loading(_that);case ContactUsStateLoaded() when loaded != null:
return loaded(_that);case ContactUsStateError() when error != null:
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
case ContactUsStateLoading() when loading != null:
return loading();case ContactUsStateLoaded() when loaded != null:
return loaded();case ContactUsStateError() when error != null:
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
case ContactUsStateLoading():
return loading();case ContactUsStateLoaded():
return loaded();case ContactUsStateError():
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
case ContactUsStateLoading() when loading != null:
return loading();case ContactUsStateLoaded() when loaded != null:
return loaded();case ContactUsStateError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class ContactUsStateLoading implements ContactUsState {
  const ContactUsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactUsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactUsState.loading()';
}


}




/// @nodoc


class ContactUsStateLoaded implements ContactUsState {
  const ContactUsStateLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactUsStateLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactUsState.loaded()';
}


}




/// @nodoc


class ContactUsStateError implements ContactUsState {
  const ContactUsStateError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactUsStateError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactUsState.error()';
}


}




// dart format on
