// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_groups_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListGroupsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListGroupsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListGroupsState()';
}


}

/// @nodoc
class $ListGroupsStateCopyWith<$Res>  {
$ListGroupsStateCopyWith(ListGroupsState _, $Res Function(ListGroupsState) __);
}


/// Adds pattern-matching-related methods to [ListGroupsState].
extension ListGroupsStatePatterns on ListGroupsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ListGroupsStateInitial value)?  initial,TResult Function( ListGroupsStateLoading value)?  loading,TResult Function( ListGroupsStateLoaded value)?  loaded,TResult Function( ListGroupsStateUpdated value)?  updated,TResult Function( ListGroupsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ListGroupsStateInitial() when initial != null:
return initial(_that);case ListGroupsStateLoading() when loading != null:
return loading(_that);case ListGroupsStateLoaded() when loaded != null:
return loaded(_that);case ListGroupsStateUpdated() when updated != null:
return updated(_that);case ListGroupsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ListGroupsStateInitial value)  initial,required TResult Function( ListGroupsStateLoading value)  loading,required TResult Function( ListGroupsStateLoaded value)  loaded,required TResult Function( ListGroupsStateUpdated value)  updated,required TResult Function( ListGroupsStateError value)  error,}){
final _that = this;
switch (_that) {
case ListGroupsStateInitial():
return initial(_that);case ListGroupsStateLoading():
return loading(_that);case ListGroupsStateLoaded():
return loaded(_that);case ListGroupsStateUpdated():
return updated(_that);case ListGroupsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ListGroupsStateInitial value)?  initial,TResult? Function( ListGroupsStateLoading value)?  loading,TResult? Function( ListGroupsStateLoaded value)?  loaded,TResult? Function( ListGroupsStateUpdated value)?  updated,TResult? Function( ListGroupsStateError value)?  error,}){
final _that = this;
switch (_that) {
case ListGroupsStateInitial() when initial != null:
return initial(_that);case ListGroupsStateLoading() when loading != null:
return loading(_that);case ListGroupsStateLoaded() when loaded != null:
return loaded(_that);case ListGroupsStateUpdated() when updated != null:
return updated(_that);case ListGroupsStateError() when error != null:
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
case ListGroupsStateInitial() when initial != null:
return initial();case ListGroupsStateLoading() when loading != null:
return loading();case ListGroupsStateLoaded() when loaded != null:
return loaded(_that.list,_that.userId);case ListGroupsStateUpdated() when updated != null:
return updated(_that.list,_that.userId);case ListGroupsStateError() when error != null:
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
case ListGroupsStateInitial():
return initial();case ListGroupsStateLoading():
return loading();case ListGroupsStateLoaded():
return loaded(_that.list,_that.userId);case ListGroupsStateUpdated():
return updated(_that.list,_that.userId);case ListGroupsStateError():
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
case ListGroupsStateInitial() when initial != null:
return initial();case ListGroupsStateLoading() when loading != null:
return loading();case ListGroupsStateLoaded() when loaded != null:
return loaded(_that.list,_that.userId);case ListGroupsStateUpdated() when updated != null:
return updated(_that.list,_that.userId);case ListGroupsStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ListGroupsStateInitial implements ListGroupsState {
  const ListGroupsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListGroupsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListGroupsState.initial()';
}


}




/// @nodoc


class ListGroupsStateLoading implements ListGroupsState {
  const ListGroupsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListGroupsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListGroupsState.loading()';
}


}




/// @nodoc


class ListGroupsStateLoaded implements ListGroupsState {
  const ListGroupsStateLoaded(final  List<ForumGroupModel> list, this.userId): _list = list;
  

 final  List<ForumGroupModel> _list;
 List<ForumGroupModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  int userId;

/// Create a copy of ListGroupsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListGroupsStateLoadedCopyWith<ListGroupsStateLoaded> get copyWith => _$ListGroupsStateLoadedCopyWithImpl<ListGroupsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListGroupsStateLoaded&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),userId);

@override
String toString() {
  return 'ListGroupsState.loaded(list: $list, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ListGroupsStateLoadedCopyWith<$Res> implements $ListGroupsStateCopyWith<$Res> {
  factory $ListGroupsStateLoadedCopyWith(ListGroupsStateLoaded value, $Res Function(ListGroupsStateLoaded) _then) = _$ListGroupsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ForumGroupModel> list, int userId
});




}
/// @nodoc
class _$ListGroupsStateLoadedCopyWithImpl<$Res>
    implements $ListGroupsStateLoadedCopyWith<$Res> {
  _$ListGroupsStateLoadedCopyWithImpl(this._self, this._then);

  final ListGroupsStateLoaded _self;
  final $Res Function(ListGroupsStateLoaded) _then;

/// Create a copy of ListGroupsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,Object? userId = null,}) {
  return _then(ListGroupsStateLoaded(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ForumGroupModel>,null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ListGroupsStateUpdated implements ListGroupsState {
  const ListGroupsStateUpdated(final  List<ForumGroupModel> list, this.userId): _list = list;
  

 final  List<ForumGroupModel> _list;
 List<ForumGroupModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  int userId;

/// Create a copy of ListGroupsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListGroupsStateUpdatedCopyWith<ListGroupsStateUpdated> get copyWith => _$ListGroupsStateUpdatedCopyWithImpl<ListGroupsStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListGroupsStateUpdated&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),userId);

@override
String toString() {
  return 'ListGroupsState.updated(list: $list, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ListGroupsStateUpdatedCopyWith<$Res> implements $ListGroupsStateCopyWith<$Res> {
  factory $ListGroupsStateUpdatedCopyWith(ListGroupsStateUpdated value, $Res Function(ListGroupsStateUpdated) _then) = _$ListGroupsStateUpdatedCopyWithImpl;
@useResult
$Res call({
 List<ForumGroupModel> list, int userId
});




}
/// @nodoc
class _$ListGroupsStateUpdatedCopyWithImpl<$Res>
    implements $ListGroupsStateUpdatedCopyWith<$Res> {
  _$ListGroupsStateUpdatedCopyWithImpl(this._self, this._then);

  final ListGroupsStateUpdated _self;
  final $Res Function(ListGroupsStateUpdated) _then;

/// Create a copy of ListGroupsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,Object? userId = null,}) {
  return _then(ListGroupsStateUpdated(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ForumGroupModel>,null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ListGroupsStateError implements ListGroupsState {
  const ListGroupsStateError(this.error);
  

 final  String error;

/// Create a copy of ListGroupsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListGroupsStateErrorCopyWith<ListGroupsStateError> get copyWith => _$ListGroupsStateErrorCopyWithImpl<ListGroupsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListGroupsStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ListGroupsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ListGroupsStateErrorCopyWith<$Res> implements $ListGroupsStateCopyWith<$Res> {
  factory $ListGroupsStateErrorCopyWith(ListGroupsStateError value, $Res Function(ListGroupsStateError) _then) = _$ListGroupsStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ListGroupsStateErrorCopyWithImpl<$Res>
    implements $ListGroupsStateErrorCopyWith<$Res> {
  _$ListGroupsStateErrorCopyWithImpl(this._self, this._then);

  final ListGroupsStateError _self;
  final $Res Function(ListGroupsStateError) _then;

/// Create a copy of ListGroupsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ListGroupsStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
