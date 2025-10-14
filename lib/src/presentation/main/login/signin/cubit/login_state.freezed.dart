// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginStateInitial value)?  initial,TResult Function( LoginStateLoading value)?  loading,TResult Function( LoginStateLoaded value)?  loaded,TResult Function( LoginStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginStateInitial() when initial != null:
return initial(_that);case LoginStateLoading() when loading != null:
return loading(_that);case LoginStateLoaded() when loaded != null:
return loaded(_that);case LoginStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginStateInitial value)  initial,required TResult Function( LoginStateLoading value)  loading,required TResult Function( LoginStateLoaded value)  loaded,required TResult Function( LoginStateError value)  error,}){
final _that = this;
switch (_that) {
case LoginStateInitial():
return initial(_that);case LoginStateLoading():
return loading(_that);case LoginStateLoaded():
return loaded(_that);case LoginStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginStateInitial value)?  initial,TResult? Function( LoginStateLoading value)?  loading,TResult? Function( LoginStateLoaded value)?  loaded,TResult? Function( LoginStateError value)?  error,}){
final _that = this;
switch (_that) {
case LoginStateInitial() when initial != null:
return initial(_that);case LoginStateLoading() when loading != null:
return loading(_that);case LoginStateLoaded() when loaded != null:
return loaded(_that);case LoginStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginStateInitial() when initial != null:
return initial();case LoginStateLoading() when loading != null:
return loading();case LoginStateLoaded() when loaded != null:
return loaded();case LoginStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case LoginStateInitial():
return initial();case LoginStateLoading():
return loading();case LoginStateLoaded():
return loaded();case LoginStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case LoginStateInitial() when initial != null:
return initial();case LoginStateLoading() when loading != null:
return loading();case LoginStateLoaded() when loaded != null:
return loaded();case LoginStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class LoginStateInitial implements LoginState {
  const LoginStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.initial()';
}


}




/// @nodoc


class LoginStateLoading implements LoginState {
  const LoginStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.loading()';
}


}




/// @nodoc


class LoginStateLoaded implements LoginState {
  const LoginStateLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStateLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.loaded()';
}


}




/// @nodoc


class LoginStateError implements LoginState {
  const LoginStateError(this.error);
  

 final  String error;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateErrorCopyWith<LoginStateError> get copyWith => _$LoginStateErrorCopyWithImpl<LoginStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'LoginState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $LoginStateErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $LoginStateErrorCopyWith(LoginStateError value, $Res Function(LoginStateError) _then) = _$LoginStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$LoginStateErrorCopyWithImpl<$Res>
    implements $LoginStateErrorCopyWith<$Res> {
  _$LoginStateErrorCopyWithImpl(this._self, this._then);

  final LoginStateError _self;
  final $Res Function(LoginStateError) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(LoginStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
