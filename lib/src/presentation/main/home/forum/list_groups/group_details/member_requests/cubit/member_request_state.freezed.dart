// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberRequestState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberRequestState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberRequestState()';
}


}

/// @nodoc
class $MemberRequestStateCopyWith<$Res>  {
$MemberRequestStateCopyWith(MemberRequestState _, $Res Function(MemberRequestState) __);
}


/// Adds pattern-matching-related methods to [MemberRequestState].
extension MemberRequestStatePatterns on MemberRequestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MemberRequestStateInitial value)?  initial,TResult Function( MemberRequestLoading value)?  loading,TResult Function( MemberRequestLoaded value)?  loaded,TResult Function( MemberRequestError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MemberRequestStateInitial() when initial != null:
return initial(_that);case MemberRequestLoading() when loading != null:
return loading(_that);case MemberRequestLoaded() when loaded != null:
return loaded(_that);case MemberRequestError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MemberRequestStateInitial value)  initial,required TResult Function( MemberRequestLoading value)  loading,required TResult Function( MemberRequestLoaded value)  loaded,required TResult Function( MemberRequestError value)  error,}){
final _that = this;
switch (_that) {
case MemberRequestStateInitial():
return initial(_that);case MemberRequestLoading():
return loading(_that);case MemberRequestLoaded():
return loaded(_that);case MemberRequestError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MemberRequestStateInitial value)?  initial,TResult? Function( MemberRequestLoading value)?  loading,TResult? Function( MemberRequestLoaded value)?  loaded,TResult? Function( MemberRequestError value)?  error,}){
final _that = this;
switch (_that) {
case MemberRequestStateInitial() when initial != null:
return initial(_that);case MemberRequestLoading() when loading != null:
return loading(_that);case MemberRequestLoaded() when loaded != null:
return loaded(_that);case MemberRequestError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MemberRequestModel> list)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MemberRequestStateInitial() when initial != null:
return initial();case MemberRequestLoading() when loading != null:
return loading();case MemberRequestLoaded() when loaded != null:
return loaded(_that.list);case MemberRequestError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MemberRequestModel> list)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case MemberRequestStateInitial():
return initial();case MemberRequestLoading():
return loading();case MemberRequestLoaded():
return loaded(_that.list);case MemberRequestError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MemberRequestModel> list)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case MemberRequestStateInitial() when initial != null:
return initial();case MemberRequestLoading() when loading != null:
return loading();case MemberRequestLoaded() when loaded != null:
return loaded(_that.list);case MemberRequestError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class MemberRequestStateInitial implements MemberRequestState {
  const MemberRequestStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberRequestStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberRequestState.initial()';
}


}




/// @nodoc


class MemberRequestLoading implements MemberRequestState {
  const MemberRequestLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberRequestLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberRequestState.loading()';
}


}




/// @nodoc


class MemberRequestLoaded implements MemberRequestState {
  const MemberRequestLoaded(final  List<MemberRequestModel> list): _list = list;
  

 final  List<MemberRequestModel> _list;
 List<MemberRequestModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of MemberRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberRequestLoadedCopyWith<MemberRequestLoaded> get copyWith => _$MemberRequestLoadedCopyWithImpl<MemberRequestLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberRequestLoaded&&const DeepCollectionEquality().equals(other._list, _list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'MemberRequestState.loaded(list: $list)';
}


}

/// @nodoc
abstract mixin class $MemberRequestLoadedCopyWith<$Res> implements $MemberRequestStateCopyWith<$Res> {
  factory $MemberRequestLoadedCopyWith(MemberRequestLoaded value, $Res Function(MemberRequestLoaded) _then) = _$MemberRequestLoadedCopyWithImpl;
@useResult
$Res call({
 List<MemberRequestModel> list
});




}
/// @nodoc
class _$MemberRequestLoadedCopyWithImpl<$Res>
    implements $MemberRequestLoadedCopyWith<$Res> {
  _$MemberRequestLoadedCopyWithImpl(this._self, this._then);

  final MemberRequestLoaded _self;
  final $Res Function(MemberRequestLoaded) _then;

/// Create a copy of MemberRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(MemberRequestLoaded(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<MemberRequestModel>,
  ));
}


}

/// @nodoc


class MemberRequestError implements MemberRequestState {
  const MemberRequestError(this.error);
  

 final  String error;

/// Create a copy of MemberRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberRequestErrorCopyWith<MemberRequestError> get copyWith => _$MemberRequestErrorCopyWithImpl<MemberRequestError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberRequestError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'MemberRequestState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $MemberRequestErrorCopyWith<$Res> implements $MemberRequestStateCopyWith<$Res> {
  factory $MemberRequestErrorCopyWith(MemberRequestError value, $Res Function(MemberRequestError) _then) = _$MemberRequestErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$MemberRequestErrorCopyWithImpl<$Res>
    implements $MemberRequestErrorCopyWith<$Res> {
  _$MemberRequestErrorCopyWithImpl(this._self, this._then);

  final MemberRequestError _self;
  final $Res Function(MemberRequestError) _then;

/// Create a copy of MemberRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(MemberRequestError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
