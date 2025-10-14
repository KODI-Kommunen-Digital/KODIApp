// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupDetailsState()';
}


}

/// @nodoc
class $GroupDetailsStateCopyWith<$Res>  {
$GroupDetailsStateCopyWith(GroupDetailsState _, $Res Function(GroupDetailsState) __);
}


/// Adds pattern-matching-related methods to [GroupDetailsState].
extension GroupDetailsStatePatterns on GroupDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GroupDetailsStateInitial value)?  initial,TResult Function( GroupDetailsStateLoading value)?  loading,TResult Function( GroupDetailsStateLoaded value)?  loaded,TResult Function( GroupDetailsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GroupDetailsStateInitial() when initial != null:
return initial(_that);case GroupDetailsStateLoading() when loading != null:
return loading(_that);case GroupDetailsStateLoaded() when loaded != null:
return loaded(_that);case GroupDetailsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GroupDetailsStateInitial value)  initial,required TResult Function( GroupDetailsStateLoading value)  loading,required TResult Function( GroupDetailsStateLoaded value)  loaded,required TResult Function( GroupDetailsStateError value)  error,}){
final _that = this;
switch (_that) {
case GroupDetailsStateInitial():
return initial(_that);case GroupDetailsStateLoading():
return loading(_that);case GroupDetailsStateLoaded():
return loaded(_that);case GroupDetailsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GroupDetailsStateInitial value)?  initial,TResult? Function( GroupDetailsStateLoading value)?  loading,TResult? Function( GroupDetailsStateLoaded value)?  loaded,TResult? Function( GroupDetailsStateError value)?  error,}){
final _that = this;
switch (_that) {
case GroupDetailsStateInitial() when initial != null:
return initial(_that);case GroupDetailsStateLoading() when loading != null:
return loading(_that);case GroupDetailsStateLoaded() when loaded != null:
return loaded(_that);case GroupDetailsStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<GroupPostsModel> list,  ForumGroupModel arguments,  bool isAdmin,  int userId)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GroupDetailsStateInitial() when initial != null:
return initial();case GroupDetailsStateLoading() when loading != null:
return loading();case GroupDetailsStateLoaded() when loaded != null:
return loaded(_that.list,_that.arguments,_that.isAdmin,_that.userId);case GroupDetailsStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<GroupPostsModel> list,  ForumGroupModel arguments,  bool isAdmin,  int userId)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case GroupDetailsStateInitial():
return initial();case GroupDetailsStateLoading():
return loading();case GroupDetailsStateLoaded():
return loaded(_that.list,_that.arguments,_that.isAdmin,_that.userId);case GroupDetailsStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<GroupPostsModel> list,  ForumGroupModel arguments,  bool isAdmin,  int userId)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case GroupDetailsStateInitial() when initial != null:
return initial();case GroupDetailsStateLoading() when loading != null:
return loading();case GroupDetailsStateLoaded() when loaded != null:
return loaded(_that.list,_that.arguments,_that.isAdmin,_that.userId);case GroupDetailsStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class GroupDetailsStateInitial implements GroupDetailsState {
  const GroupDetailsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupDetailsState.initial()';
}


}




/// @nodoc


class GroupDetailsStateLoading implements GroupDetailsState {
  const GroupDetailsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupDetailsState.loading()';
}


}




/// @nodoc


class GroupDetailsStateLoaded implements GroupDetailsState {
  const GroupDetailsStateLoaded(final  List<GroupPostsModel> list, this.arguments, this.isAdmin, this.userId): _list = list;
  

 final  List<GroupPostsModel> _list;
 List<GroupPostsModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  ForumGroupModel arguments;
 final  bool isAdmin;
 final  int userId;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupDetailsStateLoadedCopyWith<GroupDetailsStateLoaded> get copyWith => _$GroupDetailsStateLoadedCopyWithImpl<GroupDetailsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailsStateLoaded&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.arguments, arguments) || other.arguments == arguments)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),arguments,isAdmin,userId);

@override
String toString() {
  return 'GroupDetailsState.loaded(list: $list, arguments: $arguments, isAdmin: $isAdmin, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $GroupDetailsStateLoadedCopyWith<$Res> implements $GroupDetailsStateCopyWith<$Res> {
  factory $GroupDetailsStateLoadedCopyWith(GroupDetailsStateLoaded value, $Res Function(GroupDetailsStateLoaded) _then) = _$GroupDetailsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<GroupPostsModel> list, ForumGroupModel arguments, bool isAdmin, int userId
});




}
/// @nodoc
class _$GroupDetailsStateLoadedCopyWithImpl<$Res>
    implements $GroupDetailsStateLoadedCopyWith<$Res> {
  _$GroupDetailsStateLoadedCopyWithImpl(this._self, this._then);

  final GroupDetailsStateLoaded _self;
  final $Res Function(GroupDetailsStateLoaded) _then;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,Object? arguments = null,Object? isAdmin = null,Object? userId = null,}) {
  return _then(GroupDetailsStateLoaded(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<GroupPostsModel>,null == arguments ? _self.arguments : arguments // ignore: cast_nullable_to_non_nullable
as ForumGroupModel,null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class GroupDetailsStateError implements GroupDetailsState {
  const GroupDetailsStateError(this.error);
  

 final  String error;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupDetailsStateErrorCopyWith<GroupDetailsStateError> get copyWith => _$GroupDetailsStateErrorCopyWithImpl<GroupDetailsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailsStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'GroupDetailsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $GroupDetailsStateErrorCopyWith<$Res> implements $GroupDetailsStateCopyWith<$Res> {
  factory $GroupDetailsStateErrorCopyWith(GroupDetailsStateError value, $Res Function(GroupDetailsStateError) _then) = _$GroupDetailsStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$GroupDetailsStateErrorCopyWithImpl<$Res>
    implements $GroupDetailsStateErrorCopyWith<$Res> {
  _$GroupDetailsStateErrorCopyWithImpl(this._self, this._then);

  final GroupDetailsStateError _self;
  final $Res Function(GroupDetailsStateError) _then;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(GroupDetailsStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
