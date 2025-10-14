// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactState()';
}


}

/// @nodoc
class $ContactStateCopyWith<$Res>  {
$ContactStateCopyWith(ContactState _, $Res Function(ContactState) __);
}


/// Adds pattern-matching-related methods to [ContactState].
extension ContactStatePatterns on ContactState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ContactStateInitial value)?  initial,TResult Function( ContactStateLoading value)?  loading,TResult Function( ContactStateLoaded value)?  loaded,TResult Function( ContactStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ContactStateInitial() when initial != null:
return initial(_that);case ContactStateLoading() when loading != null:
return loading(_that);case ContactStateLoaded() when loaded != null:
return loaded(_that);case ContactStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ContactStateInitial value)  initial,required TResult Function( ContactStateLoading value)  loading,required TResult Function( ContactStateLoaded value)  loaded,required TResult Function( ContactStateError value)  error,}){
final _that = this;
switch (_that) {
case ContactStateInitial():
return initial(_that);case ContactStateLoading():
return loading(_that);case ContactStateLoaded():
return loaded(_that);case ContactStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ContactStateInitial value)?  initial,TResult? Function( ContactStateLoading value)?  loading,TResult? Function( ContactStateLoaded value)?  loaded,TResult? Function( ContactStateError value)?  error,}){
final _that = this;
switch (_that) {
case ContactStateInitial() when initial != null:
return initial(_that);case ContactStateLoading() when loading != null:
return loading(_that);case ContactStateLoaded() when loaded != null:
return loaded(_that);case ContactStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ContactPerson> list)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ContactStateInitial() when initial != null:
return initial();case ContactStateLoading() when loading != null:
return loading();case ContactStateLoaded() when loaded != null:
return loaded(_that.list);case ContactStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ContactPerson> list)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case ContactStateInitial():
return initial();case ContactStateLoading():
return loading();case ContactStateLoaded():
return loaded(_that.list);case ContactStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ContactPerson> list)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case ContactStateInitial() when initial != null:
return initial();case ContactStateLoading() when loading != null:
return loading();case ContactStateLoaded() when loaded != null:
return loaded(_that.list);case ContactStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ContactStateInitial implements ContactState {
  const ContactStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactState.initial()';
}


}




/// @nodoc


class ContactStateLoading implements ContactState {
  const ContactStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactState.loading()';
}


}




/// @nodoc


class ContactStateLoaded implements ContactState {
  const ContactStateLoaded(final  List<ContactPerson> list): _list = list;
  

 final  List<ContactPerson> _list;
 List<ContactPerson> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactStateLoadedCopyWith<ContactStateLoaded> get copyWith => _$ContactStateLoadedCopyWithImpl<ContactStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactStateLoaded&&const DeepCollectionEquality().equals(other._list, _list));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'ContactState.loaded(list: $list)';
}


}

/// @nodoc
abstract mixin class $ContactStateLoadedCopyWith<$Res> implements $ContactStateCopyWith<$Res> {
  factory $ContactStateLoadedCopyWith(ContactStateLoaded value, $Res Function(ContactStateLoaded) _then) = _$ContactStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ContactPerson> list
});




}
/// @nodoc
class _$ContactStateLoadedCopyWithImpl<$Res>
    implements $ContactStateLoadedCopyWith<$Res> {
  _$ContactStateLoadedCopyWithImpl(this._self, this._then);

  final ContactStateLoaded _self;
  final $Res Function(ContactStateLoaded) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(ContactStateLoaded(
null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ContactPerson>,
  ));
}


}

/// @nodoc


class ContactStateError implements ContactState {
  const ContactStateError(this.error);
  

 final  String error;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactStateErrorCopyWith<ContactStateError> get copyWith => _$ContactStateErrorCopyWithImpl<ContactStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ContactState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ContactStateErrorCopyWith<$Res> implements $ContactStateCopyWith<$Res> {
  factory $ContactStateErrorCopyWith(ContactStateError value, $Res Function(ContactStateError) _then) = _$ContactStateErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ContactStateErrorCopyWithImpl<$Res>
    implements $ContactStateErrorCopyWith<$Res> {
  _$ContactStateErrorCopyWithImpl(this._self, this._then);

  final ContactStateError _self;
  final $Res Function(ContactStateError) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ContactStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
