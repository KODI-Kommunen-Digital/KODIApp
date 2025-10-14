// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState()';
}


}

/// @nodoc
class $ApplicationStateCopyWith<$Res>  {
$ApplicationStateCopyWith(ApplicationState _, $Res Function(ApplicationState) __);
}


/// Adds pattern-matching-related methods to [ApplicationState].
extension ApplicationStatePatterns on ApplicationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ApplicationLoading value)?  loading,TResult Function( ApplicationLoaded value)?  loaded,TResult Function( ApplicationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ApplicationLoading() when loading != null:
return loading(_that);case ApplicationLoaded() when loaded != null:
return loaded(_that);case ApplicationError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ApplicationLoading value)  loading,required TResult Function( ApplicationLoaded value)  loaded,required TResult Function( ApplicationError value)  error,}){
final _that = this;
switch (_that) {
case ApplicationLoading():
return loading(_that);case ApplicationLoaded():
return loaded(_that);case ApplicationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ApplicationLoading value)?  loading,TResult? Function( ApplicationLoaded value)?  loaded,TResult? Function( ApplicationError value)?  error,}){
final _that = this;
switch (_that) {
case ApplicationLoading() when loading != null:
return loading(_that);case ApplicationLoaded() when loaded != null:
return loaded(_that);case ApplicationError() when error != null:
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
case ApplicationLoading() when loading != null:
return loading();case ApplicationLoaded() when loaded != null:
return loaded();case ApplicationError() when error != null:
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
case ApplicationLoading():
return loading();case ApplicationLoaded():
return loaded();case ApplicationError():
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
case ApplicationLoading() when loading != null:
return loading();case ApplicationLoaded() when loaded != null:
return loaded();case ApplicationError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class ApplicationLoading implements ApplicationState {
  const ApplicationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.loading()';
}


}




/// @nodoc


class ApplicationLoaded implements ApplicationState {
  const ApplicationLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.loaded()';
}


}




/// @nodoc


class ApplicationError implements ApplicationState {
  const ApplicationError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.error()';
}


}




// dart format on
