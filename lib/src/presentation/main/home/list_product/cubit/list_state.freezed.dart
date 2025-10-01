// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListState()';
}


}

/// @nodoc
class $ListStateCopyWith<$Res>  {
$ListStateCopyWith(ListState _, $Res Function(ListState) __);
}


/// Adds pattern-matching-related methods to [ListState].
extension ListStatePatterns on ListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ListStateInitial value)?  initial,TResult Function( ListStateLoading value)?  loading,TResult Function( ListStateLoaded value)?  loaded,TResult Function( ListStateUpdated value)?  updated,TResult Function( ListStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ListStateInitial() when initial != null:
return initial(_that);case ListStateLoading() when loading != null:
return loading(_that);case ListStateLoaded() when loaded != null:
return loaded(_that);case ListStateUpdated() when updated != null:
return updated(_that);case ListStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ListStateInitial value)  initial,required TResult Function( ListStateLoading value)  loading,required TResult Function( ListStateLoaded value)  loaded,required TResult Function( ListStateUpdated value)  updated,required TResult Function( ListStateError value)  error,}){
final _that = this;
switch (_that) {
case ListStateInitial():
return initial(_that);case ListStateLoading():
return loading(_that);case ListStateLoaded():
return loaded(_that);case ListStateUpdated():
return updated(_that);case ListStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ListStateInitial value)?  initial,TResult? Function( ListStateLoading value)?  loading,TResult? Function( ListStateLoaded value)?  loaded,TResult? Function( ListStateUpdated value)?  updated,TResult? Function( ListStateError value)?  error,}){
final _that = this;
switch (_that) {
case ListStateInitial() when initial != null:
return initial(_that);case ListStateLoading() when loading != null:
return loading(_that);case ListStateLoaded() when loaded != null:
return loaded(_that);case ListStateUpdated() when updated != null:
return updated(_that);case ListStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ProductModel> list,  List<ProductModel>? recentList)?  loaded,TResult Function( List<ProductModel> list,  List<ProductModel>? recentList)?  updated,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ListStateInitial() when initial != null:
return initial();case ListStateLoading() when loading != null:
return loading();case ListStateLoaded() when loaded != null:
return loaded(_that.list,_that.recentList);case ListStateUpdated() when updated != null:
return updated(_that.list,_that.recentList);case ListStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ProductModel> list,  List<ProductModel>? recentList)  loaded,required TResult Function( List<ProductModel> list,  List<ProductModel>? recentList)  updated,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case ListStateInitial():
return initial();case ListStateLoading():
return loading();case ListStateLoaded():
return loaded(_that.list,_that.recentList);case ListStateUpdated():
return updated(_that.list,_that.recentList);case ListStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ProductModel> list,  List<ProductModel>? recentList)?  loaded,TResult? Function( List<ProductModel> list,  List<ProductModel>? recentList)?  updated,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case ListStateInitial() when initial != null:
return initial();case ListStateLoading() when loading != null:
return loading();case ListStateLoaded() when loaded != null:
return loaded(_that.list,_that.recentList);case ListStateUpdated() when updated != null:
return updated(_that.list,_that.recentList);case ListStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ListStateInitial implements ListState {
  const ListStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListState.initial()';
}


}




/// @nodoc


class ListStateLoading implements ListState {
  const ListStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListState.loading()';
}


}




/// @nodoc


class ListStateLoaded implements ListState {
  const ListStateLoaded(final  List<ProductModel> list, final  List<ProductModel>? recentList): _list = list,_recentList = recentList;
  

 final  List<ProductModel> _list;
 List<ProductModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  List<ProductModel>? _recentList;
 List<ProductModel>? get recentList {
  final value = _recentList;
  if (value == null) return null;
  if (_recentList is EqualUnmodifiableListView) return _recentList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListStateLoadedCopyWith<ListStateLoaded> get copyWith => _$ListStateLoadedCopyWithImpl<ListStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListStateLoaded&&const DeepCollectionEquality().equals(other._list, _list)&&const DeepCollectionEquality().equals(other._recentList, _recentList));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),const DeepCollectionEquality().hash(_recentList));

@override
String toString() {
  return 'ListState.loaded(list: $list, recentList: $recentList)';
}


}

/// @nodoc
abstract mixin class $ListStateLoadedCopyWith<$Res> implements $ListStateCopyWith<$Res> {
  factory $ListStateLoadedCopyWith(ListStateLoaded value, $Res Function(ListStateLoaded) _then) = _$ListStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> list, List<ProductModel>? recentList
});




}
/// @nodoc
class _$ListStateLoadedCopyWithImpl<$Res>
    implements $ListStateLoadedCopyWith<$Res> {
  _$ListStateLoadedCopyWithImpl(this._self, this._then);

  final ListStateLoaded _self;
  final $Res Function(ListStateLoaded) _then;

/// Create a copy of ListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,Object? recentList = freezed,}) {
  return _then(ListStateLoaded(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,freezed == recentList ? _self._recentList : recentList // ignore: cast_nullable_to_non_nullable
as List<ProductModel>?,
  ));
}


}

/// @nodoc


class ListStateUpdated implements ListState {
  const ListStateUpdated(final  List<ProductModel> list, final  List<ProductModel>? recentList): _list = list,_recentList = recentList;
  

 final  List<ProductModel> _list;
 List<ProductModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  List<ProductModel>? _recentList;
 List<ProductModel>? get recentList {
  final value = _recentList;
  if (value == null) return null;
  if (_recentList is EqualUnmodifiableListView) return _recentList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListStateUpdatedCopyWith<ListStateUpdated> get copyWith => _$ListStateUpdatedCopyWithImpl<ListStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListStateUpdated&&const DeepCollectionEquality().equals(other._list, _list)&&const DeepCollectionEquality().equals(other._recentList, _recentList));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),const DeepCollectionEquality().hash(_recentList));

@override
String toString() {
  return 'ListState.updated(list: $list, recentList: $recentList)';
}


}

/// @nodoc
abstract mixin class $ListStateUpdatedCopyWith<$Res> implements $ListStateCopyWith<$Res> {
  factory $ListStateUpdatedCopyWith(ListStateUpdated value, $Res Function(ListStateUpdated) _then) = _$ListStateUpdatedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> list, List<ProductModel>? recentList
});




}
/// @nodoc
class _$ListStateUpdatedCopyWithImpl<$Res>
    implements $ListStateUpdatedCopyWith<$Res> {
  _$ListStateUpdatedCopyWithImpl(this._self, this._then);

  final ListStateUpdated _self;
  final $Res Function(ListStateUpdated) _then;

/// Create a copy of ListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,Object? recentList = freezed,}) {
  return _then(ListStateUpdated(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,freezed == recentList ? _self._recentList : recentList // ignore: cast_nullable_to_non_nullable
as List<ProductModel>?,
  ));
}


}

/// @nodoc


class ListStateError implements ListState {
  const ListStateError(this.error);
  

 final  String error;

/// Create a copy of ListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListStateErrorCopyWith<ListStateError> get copyWith => _$ListStateErrorCopyWithImpl<ListStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ListState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ListStateErrorCopyWith<$Res> implements $ListStateCopyWith<$Res> {
  factory $ListStateErrorCopyWith(ListStateError value, $Res Function(ListStateError) _then) = _$ListStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ListStateErrorCopyWithImpl<$Res>
    implements $ListStateErrorCopyWith<$Res> {
  _$ListStateErrorCopyWithImpl(this._self, this._then);

  final ListStateError _self;
  final $Res Function(ListStateError) _then;

/// Create a copy of ListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ListStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
