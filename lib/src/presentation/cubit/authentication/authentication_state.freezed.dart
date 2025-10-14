// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthenticationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState()';
}


}

/// @nodoc
class $AuthenticationStateCopyWith<$Res>  {
$AuthenticationStateCopyWith(AuthenticationState _, $Res Function(AuthenticationState) __);
}


/// Adds pattern-matching-related methods to [AuthenticationState].
extension AuthenticationStatePatterns on AuthenticationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthenticationInitial value)?  initial,TResult Function( AuthenticationLoading value)?  loading,TResult Function( AuthenticationLoaded value)?  loaded,TResult Function( AuthenticationFailed value)?  failed,TResult Function( AuthenticationLoggedIn value)?  loggedIn,TResult Function( AuthenticationLoggedOut value)?  loggedOut,TResult Function( AuthenticationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthenticationInitial() when initial != null:
return initial(_that);case AuthenticationLoading() when loading != null:
return loading(_that);case AuthenticationLoaded() when loaded != null:
return loaded(_that);case AuthenticationFailed() when failed != null:
return failed(_that);case AuthenticationLoggedIn() when loggedIn != null:
return loggedIn(_that);case AuthenticationLoggedOut() when loggedOut != null:
return loggedOut(_that);case AuthenticationError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthenticationInitial value)  initial,required TResult Function( AuthenticationLoading value)  loading,required TResult Function( AuthenticationLoaded value)  loaded,required TResult Function( AuthenticationFailed value)  failed,required TResult Function( AuthenticationLoggedIn value)  loggedIn,required TResult Function( AuthenticationLoggedOut value)  loggedOut,required TResult Function( AuthenticationError value)  error,}){
final _that = this;
switch (_that) {
case AuthenticationInitial():
return initial(_that);case AuthenticationLoading():
return loading(_that);case AuthenticationLoaded():
return loaded(_that);case AuthenticationFailed():
return failed(_that);case AuthenticationLoggedIn():
return loggedIn(_that);case AuthenticationLoggedOut():
return loggedOut(_that);case AuthenticationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthenticationInitial value)?  initial,TResult? Function( AuthenticationLoading value)?  loading,TResult? Function( AuthenticationLoaded value)?  loaded,TResult? Function( AuthenticationFailed value)?  failed,TResult? Function( AuthenticationLoggedIn value)?  loggedIn,TResult? Function( AuthenticationLoggedOut value)?  loggedOut,TResult? Function( AuthenticationError value)?  error,}){
final _that = this;
switch (_that) {
case AuthenticationInitial() when initial != null:
return initial(_that);case AuthenticationLoading() when loading != null:
return loading(_that);case AuthenticationLoaded() when loaded != null:
return loaded(_that);case AuthenticationFailed() when failed != null:
return failed(_that);case AuthenticationLoggedIn() when loggedIn != null:
return loggedIn(_that);case AuthenticationLoggedOut() when loggedOut != null:
return loggedOut(_that);case AuthenticationError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  loaded,TResult Function()?  failed,TResult Function()?  loggedIn,TResult Function()?  loggedOut,TResult Function( String errorMessage)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthenticationInitial() when initial != null:
return initial();case AuthenticationLoading() when loading != null:
return loading();case AuthenticationLoaded() when loaded != null:
return loaded();case AuthenticationFailed() when failed != null:
return failed();case AuthenticationLoggedIn() when loggedIn != null:
return loggedIn();case AuthenticationLoggedOut() when loggedOut != null:
return loggedOut();case AuthenticationError() when error != null:
return error(_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function()  failed,required TResult Function()  loggedIn,required TResult Function()  loggedOut,required TResult Function( String errorMessage)  error,}) {final _that = this;
switch (_that) {
case AuthenticationInitial():
return initial();case AuthenticationLoading():
return loading();case AuthenticationLoaded():
return loaded();case AuthenticationFailed():
return failed();case AuthenticationLoggedIn():
return loggedIn();case AuthenticationLoggedOut():
return loggedOut();case AuthenticationError():
return error(_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function()?  failed,TResult? Function()?  loggedIn,TResult? Function()?  loggedOut,TResult? Function( String errorMessage)?  error,}) {final _that = this;
switch (_that) {
case AuthenticationInitial() when initial != null:
return initial();case AuthenticationLoading() when loading != null:
return loading();case AuthenticationLoaded() when loaded != null:
return loaded();case AuthenticationFailed() when failed != null:
return failed();case AuthenticationLoggedIn() when loggedIn != null:
return loggedIn();case AuthenticationLoggedOut() when loggedOut != null:
return loggedOut();case AuthenticationError() when error != null:
return error(_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class AuthenticationInitial implements AuthenticationState {
  const AuthenticationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.initial()';
}


}




/// @nodoc


class AuthenticationLoading implements AuthenticationState {
  const AuthenticationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.loading()';
}


}




/// @nodoc


class AuthenticationLoaded implements AuthenticationState {
  const AuthenticationLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.loaded()';
}


}




/// @nodoc


class AuthenticationFailed implements AuthenticationState {
  const AuthenticationFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.failed()';
}


}




/// @nodoc


class AuthenticationLoggedIn implements AuthenticationState {
  const AuthenticationLoggedIn();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationLoggedIn);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.loggedIn()';
}


}




/// @nodoc


class AuthenticationLoggedOut implements AuthenticationState {
  const AuthenticationLoggedOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationLoggedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.loggedOut()';
}


}




/// @nodoc


class AuthenticationError implements AuthenticationState {
  const AuthenticationError(this.errorMessage);
  

 final  String errorMessage;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationErrorCopyWith<AuthenticationError> get copyWith => _$AuthenticationErrorCopyWithImpl<AuthenticationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationError&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'AuthenticationState.error(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AuthenticationErrorCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationErrorCopyWith(AuthenticationError value, $Res Function(AuthenticationError) _then) = _$AuthenticationErrorCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class _$AuthenticationErrorCopyWithImpl<$Res>
    implements $AuthenticationErrorCopyWith<$Res> {
  _$AuthenticationErrorCopyWithImpl(this._self, this._then);

  final AuthenticationError _self;
  final $Res Function(AuthenticationError) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(AuthenticationError(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
