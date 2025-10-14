// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discovery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiscoveryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiscoveryState()';
}


}

/// @nodoc
class $DiscoveryStateCopyWith<$Res>  {
$DiscoveryStateCopyWith(DiscoveryState _, $Res Function(DiscoveryState) __);
}


/// Adds pattern-matching-related methods to [DiscoveryState].
extension DiscoveryStatePatterns on DiscoveryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DiscoveryStateInitial value)?  initial,TResult Function( DiscoveryStateLoading value)?  loading,TResult Function( DiscoveryStateLoaded value)?  loaded,TResult Function( DiscoveryStateUpdated value)?  updated,TResult Function( DiscoveryStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DiscoveryStateInitial() when initial != null:
return initial(_that);case DiscoveryStateLoading() when loading != null:
return loading(_that);case DiscoveryStateLoaded() when loaded != null:
return loaded(_that);case DiscoveryStateUpdated() when updated != null:
return updated(_that);case DiscoveryStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DiscoveryStateInitial value)  initial,required TResult Function( DiscoveryStateLoading value)  loading,required TResult Function( DiscoveryStateLoaded value)  loaded,required TResult Function( DiscoveryStateUpdated value)  updated,required TResult Function( DiscoveryStateError value)  error,}){
final _that = this;
switch (_that) {
case DiscoveryStateInitial():
return initial(_that);case DiscoveryStateLoading():
return loading(_that);case DiscoveryStateLoaded():
return loaded(_that);case DiscoveryStateUpdated():
return updated(_that);case DiscoveryStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DiscoveryStateInitial value)?  initial,TResult? Function( DiscoveryStateLoading value)?  loading,TResult? Function( DiscoveryStateLoaded value)?  loaded,TResult? Function( DiscoveryStateUpdated value)?  updated,TResult? Function( DiscoveryStateError value)?  error,}){
final _that = this;
switch (_that) {
case DiscoveryStateInitial() when initial != null:
return initial(_that);case DiscoveryStateLoading() when loading != null:
return loading(_that);case DiscoveryStateLoaded() when loaded != null:
return loaded(_that);case DiscoveryStateUpdated() when updated != null:
return updated(_that);case DiscoveryStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CitizenServiceModel> list)?  loaded,TResult Function( List<CategoryModel> list)?  updated,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DiscoveryStateInitial() when initial != null:
return initial();case DiscoveryStateLoading() when loading != null:
return loading();case DiscoveryStateLoaded() when loaded != null:
return loaded(_that.list);case DiscoveryStateUpdated() when updated != null:
return updated(_that.list);case DiscoveryStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CitizenServiceModel> list)  loaded,required TResult Function( List<CategoryModel> list)  updated,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case DiscoveryStateInitial():
return initial();case DiscoveryStateLoading():
return loading();case DiscoveryStateLoaded():
return loaded(_that.list);case DiscoveryStateUpdated():
return updated(_that.list);case DiscoveryStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CitizenServiceModel> list)?  loaded,TResult? Function( List<CategoryModel> list)?  updated,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case DiscoveryStateInitial() when initial != null:
return initial();case DiscoveryStateLoading() when loading != null:
return loading();case DiscoveryStateLoaded() when loaded != null:
return loaded(_that.list);case DiscoveryStateUpdated() when updated != null:
return updated(_that.list);case DiscoveryStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class DiscoveryStateInitial implements DiscoveryState {
  const DiscoveryStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveryStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiscoveryState.initial()';
}


}




/// @nodoc


class DiscoveryStateLoading implements DiscoveryState {
  const DiscoveryStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveryStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiscoveryState.loading()';
}


}




/// @nodoc


class DiscoveryStateLoaded implements DiscoveryState {
  const DiscoveryStateLoaded(final  List<CitizenServiceModel> list): _list = list;
  

 final  List<CitizenServiceModel> _list;
 List<CitizenServiceModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoveryStateLoadedCopyWith<DiscoveryStateLoaded> get copyWith => _$DiscoveryStateLoadedCopyWithImpl<DiscoveryStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveryStateLoaded&&const DeepCollectionEquality().equals(other._list, _list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'DiscoveryState.loaded(list: $list)';
}


}

/// @nodoc
abstract mixin class $DiscoveryStateLoadedCopyWith<$Res> implements $DiscoveryStateCopyWith<$Res> {
  factory $DiscoveryStateLoadedCopyWith(DiscoveryStateLoaded value, $Res Function(DiscoveryStateLoaded) _then) = _$DiscoveryStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<CitizenServiceModel> list
});




}
/// @nodoc
class _$DiscoveryStateLoadedCopyWithImpl<$Res>
    implements $DiscoveryStateLoadedCopyWith<$Res> {
  _$DiscoveryStateLoadedCopyWithImpl(this._self, this._then);

  final DiscoveryStateLoaded _self;
  final $Res Function(DiscoveryStateLoaded) _then;

/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(DiscoveryStateLoaded(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<CitizenServiceModel>,
  ));
}


}

/// @nodoc


class DiscoveryStateUpdated implements DiscoveryState {
  const DiscoveryStateUpdated(final  List<CategoryModel> list): _list = list;
  

 final  List<CategoryModel> _list;
 List<CategoryModel> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoveryStateUpdatedCopyWith<DiscoveryStateUpdated> get copyWith => _$DiscoveryStateUpdatedCopyWithImpl<DiscoveryStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveryStateUpdated&&const DeepCollectionEquality().equals(other._list, _list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'DiscoveryState.updated(list: $list)';
}


}

/// @nodoc
abstract mixin class $DiscoveryStateUpdatedCopyWith<$Res> implements $DiscoveryStateCopyWith<$Res> {
  factory $DiscoveryStateUpdatedCopyWith(DiscoveryStateUpdated value, $Res Function(DiscoveryStateUpdated) _then) = _$DiscoveryStateUpdatedCopyWithImpl;
@useResult
$Res call({
 List<CategoryModel> list
});




}
/// @nodoc
class _$DiscoveryStateUpdatedCopyWithImpl<$Res>
    implements $DiscoveryStateUpdatedCopyWith<$Res> {
  _$DiscoveryStateUpdatedCopyWithImpl(this._self, this._then);

  final DiscoveryStateUpdated _self;
  final $Res Function(DiscoveryStateUpdated) _then;

/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(DiscoveryStateUpdated(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,
  ));
}


}

/// @nodoc


class DiscoveryStateError implements DiscoveryState {
  const DiscoveryStateError(this.error);
  

 final  String error;

/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoveryStateErrorCopyWith<DiscoveryStateError> get copyWith => _$DiscoveryStateErrorCopyWithImpl<DiscoveryStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveryStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'DiscoveryState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $DiscoveryStateErrorCopyWith<$Res> implements $DiscoveryStateCopyWith<$Res> {
  factory $DiscoveryStateErrorCopyWith(DiscoveryStateError value, $Res Function(DiscoveryStateError) _then) = _$DiscoveryStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$DiscoveryStateErrorCopyWithImpl<$Res>
    implements $DiscoveryStateErrorCopyWith<$Res> {
  _$DiscoveryStateErrorCopyWithImpl(this._self, this._then);

  final DiscoveryStateError _self;
  final $Res Function(DiscoveryStateError) _then;

/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(DiscoveryStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
