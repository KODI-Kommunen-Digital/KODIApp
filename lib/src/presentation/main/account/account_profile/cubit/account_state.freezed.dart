// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountState()';
}


}

/// @nodoc
class $AccountStateCopyWith<$Res>  {
$AccountStateCopyWith(AccountState _, $Res Function(AccountState) __);
}


/// Adds pattern-matching-related methods to [AccountState].
extension AccountStatePatterns on AccountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountLoading value)?  loading,TResult Function( AccountLoaded value)?  loaded,TResult Function( AccountError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountLoading() when loading != null:
return loading(_that);case AccountLoaded() when loaded != null:
return loaded(_that);case AccountError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountLoading value)  loading,required TResult Function( AccountLoaded value)  loaded,required TResult Function( AccountError value)  error,}){
final _that = this;
switch (_that) {
case AccountLoading():
return loading(_that);case AccountLoaded():
return loaded(_that);case AccountError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountLoading value)?  loading,TResult? Function( AccountLoaded value)?  loaded,TResult? Function( AccountError value)?  error,}){
final _that = this;
switch (_that) {
case AccountLoading() when loading != null:
return loading(_that);case AccountLoaded() when loaded != null:
return loaded(_that);case AccountError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  loaded,TResult Function( String errorMessage)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountLoading() when loading != null:
return loading();case AccountLoaded() when loaded != null:
return loaded();case AccountError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  loaded,required TResult Function( String errorMessage)  error,}) {final _that = this;
switch (_that) {
case AccountLoading():
return loading();case AccountLoaded():
return loaded();case AccountError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function( String errorMessage)?  error,}) {final _that = this;
switch (_that) {
case AccountLoading() when loading != null:
return loading();case AccountLoaded() when loaded != null:
return loaded();case AccountError() when error != null:
return error(_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class AccountLoading implements AccountState {
  const AccountLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountState.loading()';
}


}




/// @nodoc


class AccountLoaded implements AccountState {
  const AccountLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountState.loaded()';
}


}




/// @nodoc


class AccountError implements AccountState {
  const AccountError(this.errorMessage);
  

 final  String errorMessage;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountErrorCopyWith<AccountError> get copyWith => _$AccountErrorCopyWithImpl<AccountError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountError&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'AccountState.error(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AccountErrorCopyWith<$Res> implements $AccountStateCopyWith<$Res> {
  factory $AccountErrorCopyWith(AccountError value, $Res Function(AccountError) _then) = _$AccountErrorCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class _$AccountErrorCopyWithImpl<$Res>
    implements $AccountErrorCopyWith<$Res> {
  _$AccountErrorCopyWithImpl(this._self, this._then);

  final AccountError _self;
  final $Res Function(AccountError) _then;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(AccountError(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
