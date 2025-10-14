// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_members_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupMembersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMembersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupMembersState()';
}


}

/// @nodoc
class $GroupMembersStateCopyWith<$Res>  {
$GroupMembersStateCopyWith(GroupMembersState _, $Res Function(GroupMembersState) __);
}


/// Adds pattern-matching-related methods to [GroupMembersState].
extension GroupMembersStatePatterns on GroupMembersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GroupMembersStateInitial value)?  initial,TResult Function( GroupMembersLoading value)?  loading,TResult Function( GroupMembersLoaded value)?  loaded,TResult Function( GroupMembersStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GroupMembersStateInitial() when initial != null:
return initial(_that);case GroupMembersLoading() when loading != null:
return loading(_that);case GroupMembersLoaded() when loaded != null:
return loaded(_that);case GroupMembersStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GroupMembersStateInitial value)  initial,required TResult Function( GroupMembersLoading value)  loading,required TResult Function( GroupMembersLoaded value)  loaded,required TResult Function( GroupMembersStateError value)  error,}){
final _that = this;
switch (_that) {
case GroupMembersStateInitial():
return initial(_that);case GroupMembersLoading():
return loading(_that);case GroupMembersLoaded():
return loaded(_that);case GroupMembersStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GroupMembersStateInitial value)?  initial,TResult? Function( GroupMembersLoading value)?  loading,TResult? Function( GroupMembersLoaded value)?  loaded,TResult? Function( GroupMembersStateError value)?  error,}){
final _that = this;
switch (_that) {
case GroupMembersStateInitial() when initial != null:
return initial(_that);case GroupMembersLoading() when loading != null:
return loading(_that);case GroupMembersLoaded() when loaded != null:
return loaded(_that);case GroupMembersStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<GroupMembersModel> list,  bool isAdmin)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GroupMembersStateInitial() when initial != null:
return initial();case GroupMembersLoading() when loading != null:
return loading();case GroupMembersLoaded() when loaded != null:
return loaded(_that.list,_that.isAdmin);case GroupMembersStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<GroupMembersModel> list,  bool isAdmin)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case GroupMembersStateInitial():
return initial();case GroupMembersLoading():
return loading();case GroupMembersLoaded():
return loaded(_that.list,_that.isAdmin);case GroupMembersStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<GroupMembersModel> list,  bool isAdmin)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case GroupMembersStateInitial() when initial != null:
return initial();case GroupMembersLoading() when loading != null:
return loading();case GroupMembersLoaded() when loaded != null:
return loaded(_that.list,_that.isAdmin);case GroupMembersStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class GroupMembersStateInitial implements GroupMembersState {
  const GroupMembersStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMembersStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupMembersState.initial()';
}


}




/// @nodoc


class GroupMembersLoading implements GroupMembersState {
  const GroupMembersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMembersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupMembersState.loading()';
}


}




/// @nodoc


class GroupMembersLoaded implements GroupMembersState {
  const GroupMembersLoaded(final  List<GroupMembersModel> list, this.isAdmin): _list = list;
  

 final  List<GroupMembersModel> _list;
 List<GroupMembersModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  bool isAdmin;

/// Create a copy of GroupMembersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupMembersLoadedCopyWith<GroupMembersLoaded> get copyWith => _$GroupMembersLoadedCopyWithImpl<GroupMembersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMembersLoaded&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),isAdmin);

@override
String toString() {
  return 'GroupMembersState.loaded(list: $list, isAdmin: $isAdmin)';
}


}

/// @nodoc
abstract mixin class $GroupMembersLoadedCopyWith<$Res> implements $GroupMembersStateCopyWith<$Res> {
  factory $GroupMembersLoadedCopyWith(GroupMembersLoaded value, $Res Function(GroupMembersLoaded) _then) = _$GroupMembersLoadedCopyWithImpl;
@useResult
$Res call({
 List<GroupMembersModel> list, bool isAdmin
});




}
/// @nodoc
class _$GroupMembersLoadedCopyWithImpl<$Res>
    implements $GroupMembersLoadedCopyWith<$Res> {
  _$GroupMembersLoadedCopyWithImpl(this._self, this._then);

  final GroupMembersLoaded _self;
  final $Res Function(GroupMembersLoaded) _then;

/// Create a copy of GroupMembersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,Object? isAdmin = null,}) {
  return _then(GroupMembersLoaded(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<GroupMembersModel>,null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class GroupMembersStateError implements GroupMembersState {
  const GroupMembersStateError(this.error);
  

 final  String error;

/// Create a copy of GroupMembersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupMembersStateErrorCopyWith<GroupMembersStateError> get copyWith => _$GroupMembersStateErrorCopyWithImpl<GroupMembersStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMembersStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'GroupMembersState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $GroupMembersStateErrorCopyWith<$Res> implements $GroupMembersStateCopyWith<$Res> {
  factory $GroupMembersStateErrorCopyWith(GroupMembersStateError value, $Res Function(GroupMembersStateError) _then) = _$GroupMembersStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$GroupMembersStateErrorCopyWithImpl<$Res>
    implements $GroupMembersStateErrorCopyWith<$Res> {
  _$GroupMembersStateErrorCopyWithImpl(this._self, this._then);

  final GroupMembersStateError _self;
  final $Res Function(GroupMembersStateError) _then;

/// Create a copy of GroupMembersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(GroupMembersStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
