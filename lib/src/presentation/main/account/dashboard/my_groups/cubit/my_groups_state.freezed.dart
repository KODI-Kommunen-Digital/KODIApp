// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_groups_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyGroupsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyGroupsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyGroupsState()';
}


}

/// @nodoc
class $MyGroupsStateCopyWith<$Res>  {
$MyGroupsStateCopyWith(MyGroupsState _, $Res Function(MyGroupsState) __);
}


/// Adds pattern-matching-related methods to [MyGroupsState].
extension MyGroupsStatePatterns on MyGroupsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MyGroupsStateInitial value)?  initial,TResult Function( MyGroupsStateLoading value)?  loading,TResult Function( MyGroupsStateLoaded value)?  loaded,TResult Function( MyGroupsStateUpdated value)?  updated,TResult Function( MyGroupsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MyGroupsStateInitial() when initial != null:
return initial(_that);case MyGroupsStateLoading() when loading != null:
return loading(_that);case MyGroupsStateLoaded() when loaded != null:
return loaded(_that);case MyGroupsStateUpdated() when updated != null:
return updated(_that);case MyGroupsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MyGroupsStateInitial value)  initial,required TResult Function( MyGroupsStateLoading value)  loading,required TResult Function( MyGroupsStateLoaded value)  loaded,required TResult Function( MyGroupsStateUpdated value)  updated,required TResult Function( MyGroupsStateError value)  error,}){
final _that = this;
switch (_that) {
case MyGroupsStateInitial():
return initial(_that);case MyGroupsStateLoading():
return loading(_that);case MyGroupsStateLoaded():
return loaded(_that);case MyGroupsStateUpdated():
return updated(_that);case MyGroupsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MyGroupsStateInitial value)?  initial,TResult? Function( MyGroupsStateLoading value)?  loading,TResult? Function( MyGroupsStateLoaded value)?  loaded,TResult? Function( MyGroupsStateUpdated value)?  updated,TResult? Function( MyGroupsStateError value)?  error,}){
final _that = this;
switch (_that) {
case MyGroupsStateInitial() when initial != null:
return initial(_that);case MyGroupsStateLoading() when loading != null:
return loading(_that);case MyGroupsStateLoaded() when loaded != null:
return loaded(_that);case MyGroupsStateUpdated() when updated != null:
return updated(_that);case MyGroupsStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ForumGroupModel> list,  int userId)?  loaded,TResult Function( List<ForumGroupModel> list,  int userId)?  updated,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MyGroupsStateInitial() when initial != null:
return initial();case MyGroupsStateLoading() when loading != null:
return loading();case MyGroupsStateLoaded() when loaded != null:
return loaded(_that.list,_that.userId);case MyGroupsStateUpdated() when updated != null:
return updated(_that.list,_that.userId);case MyGroupsStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ForumGroupModel> list,  int userId)  loaded,required TResult Function( List<ForumGroupModel> list,  int userId)  updated,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case MyGroupsStateInitial():
return initial();case MyGroupsStateLoading():
return loading();case MyGroupsStateLoaded():
return loaded(_that.list,_that.userId);case MyGroupsStateUpdated():
return updated(_that.list,_that.userId);case MyGroupsStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ForumGroupModel> list,  int userId)?  loaded,TResult? Function( List<ForumGroupModel> list,  int userId)?  updated,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case MyGroupsStateInitial() when initial != null:
return initial();case MyGroupsStateLoading() when loading != null:
return loading();case MyGroupsStateLoaded() when loaded != null:
return loaded(_that.list,_that.userId);case MyGroupsStateUpdated() when updated != null:
return updated(_that.list,_that.userId);case MyGroupsStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class MyGroupsStateInitial implements MyGroupsState {
  const MyGroupsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyGroupsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyGroupsState.initial()';
}


}




/// @nodoc


class MyGroupsStateLoading implements MyGroupsState {
  const MyGroupsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyGroupsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyGroupsState.loading()';
}


}




/// @nodoc


class MyGroupsStateLoaded implements MyGroupsState {
  const MyGroupsStateLoaded(final  List<ForumGroupModel> list, this.userId): _list = list;
  

 final  List<ForumGroupModel> _list;
 List<ForumGroupModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  int userId;

/// Create a copy of MyGroupsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyGroupsStateLoadedCopyWith<MyGroupsStateLoaded> get copyWith => _$MyGroupsStateLoadedCopyWithImpl<MyGroupsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyGroupsStateLoaded&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),userId);

@override
String toString() {
  return 'MyGroupsState.loaded(list: $list, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $MyGroupsStateLoadedCopyWith<$Res> implements $MyGroupsStateCopyWith<$Res> {
  factory $MyGroupsStateLoadedCopyWith(MyGroupsStateLoaded value, $Res Function(MyGroupsStateLoaded) _then) = _$MyGroupsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ForumGroupModel> list, int userId
});




}
/// @nodoc
class _$MyGroupsStateLoadedCopyWithImpl<$Res>
    implements $MyGroupsStateLoadedCopyWith<$Res> {
  _$MyGroupsStateLoadedCopyWithImpl(this._self, this._then);

  final MyGroupsStateLoaded _self;
  final $Res Function(MyGroupsStateLoaded) _then;

/// Create a copy of MyGroupsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,Object? userId = null,}) {
  return _then(MyGroupsStateLoaded(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ForumGroupModel>,null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class MyGroupsStateUpdated implements MyGroupsState {
  const MyGroupsStateUpdated(final  List<ForumGroupModel> list, this.userId): _list = list;
  

 final  List<ForumGroupModel> _list;
 List<ForumGroupModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  int userId;

/// Create a copy of MyGroupsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyGroupsStateUpdatedCopyWith<MyGroupsStateUpdated> get copyWith => _$MyGroupsStateUpdatedCopyWithImpl<MyGroupsStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyGroupsStateUpdated&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),userId);

@override
String toString() {
  return 'MyGroupsState.updated(list: $list, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $MyGroupsStateUpdatedCopyWith<$Res> implements $MyGroupsStateCopyWith<$Res> {
  factory $MyGroupsStateUpdatedCopyWith(MyGroupsStateUpdated value, $Res Function(MyGroupsStateUpdated) _then) = _$MyGroupsStateUpdatedCopyWithImpl;
@useResult
$Res call({
 List<ForumGroupModel> list, int userId
});




}
/// @nodoc
class _$MyGroupsStateUpdatedCopyWithImpl<$Res>
    implements $MyGroupsStateUpdatedCopyWith<$Res> {
  _$MyGroupsStateUpdatedCopyWithImpl(this._self, this._then);

  final MyGroupsStateUpdated _self;
  final $Res Function(MyGroupsStateUpdated) _then;

/// Create a copy of MyGroupsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,Object? userId = null,}) {
  return _then(MyGroupsStateUpdated(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ForumGroupModel>,null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class MyGroupsStateError implements MyGroupsState {
  const MyGroupsStateError(this.error);
  

 final  String error;

/// Create a copy of MyGroupsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyGroupsStateErrorCopyWith<MyGroupsStateError> get copyWith => _$MyGroupsStateErrorCopyWithImpl<MyGroupsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyGroupsStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'MyGroupsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $MyGroupsStateErrorCopyWith<$Res> implements $MyGroupsStateCopyWith<$Res> {
  factory $MyGroupsStateErrorCopyWith(MyGroupsStateError value, $Res Function(MyGroupsStateError) _then) = _$MyGroupsStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$MyGroupsStateErrorCopyWithImpl<$Res>
    implements $MyGroupsStateErrorCopyWith<$Res> {
  _$MyGroupsStateErrorCopyWithImpl(this._self, this._then);

  final MyGroupsStateError _self;
  final $Res Function(MyGroupsStateError) _then;

/// Create a copy of MyGroupsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(MyGroupsStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
