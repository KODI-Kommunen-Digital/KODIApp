// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ContactState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ContactPerson> list) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactPerson> list)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactPerson> list)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContactStateInitial value) initial,
    required TResult Function(ContactStateLoading value) loading,
    required TResult Function(ContactStateLoaded value) loaded,
    required TResult Function(ContactStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContactStateInitial value)? initial,
    TResult? Function(ContactStateLoading value)? loading,
    TResult? Function(ContactStateLoaded value)? loaded,
    TResult? Function(ContactStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContactStateInitial value)? initial,
    TResult Function(ContactStateLoading value)? loading,
    TResult Function(ContactStateLoaded value)? loaded,
    TResult Function(ContactStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactStateCopyWith<$Res> {
  factory $ContactStateCopyWith(
          ContactState value, $Res Function(ContactState) then) =
      _$ContactStateCopyWithImpl<$Res, ContactState>;
}

/// @nodoc
class _$ContactStateCopyWithImpl<$Res, $Val extends ContactState>
    implements $ContactStateCopyWith<$Res> {
  _$ContactStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ContactStateInitialCopyWith<$Res> {
  factory _$$ContactStateInitialCopyWith(_$ContactStateInitial value,
          $Res Function(_$ContactStateInitial) then) =
      __$$ContactStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContactStateInitialCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateInitial>
    implements _$$ContactStateInitialCopyWith<$Res> {
  __$$ContactStateInitialCopyWithImpl(
      _$ContactStateInitial _value, $Res Function(_$ContactStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ContactStateInitial implements ContactStateInitial {
  const _$ContactStateInitial();

  @override
  String toString() {
    return 'ContactState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ContactStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ContactPerson> list) loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactPerson> list)? loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactPerson> list)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContactStateInitial value) initial,
    required TResult Function(ContactStateLoading value) loading,
    required TResult Function(ContactStateLoaded value) loaded,
    required TResult Function(ContactStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContactStateInitial value)? initial,
    TResult? Function(ContactStateLoading value)? loading,
    TResult? Function(ContactStateLoaded value)? loaded,
    TResult? Function(ContactStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContactStateInitial value)? initial,
    TResult Function(ContactStateLoading value)? loading,
    TResult Function(ContactStateLoaded value)? loaded,
    TResult Function(ContactStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ContactStateInitial implements ContactState {
  const factory ContactStateInitial() = _$ContactStateInitial;
}

/// @nodoc
abstract class _$$ContactStateLoadingCopyWith<$Res> {
  factory _$$ContactStateLoadingCopyWith(_$ContactStateLoading value,
          $Res Function(_$ContactStateLoading) then) =
      __$$ContactStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContactStateLoadingCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateLoading>
    implements _$$ContactStateLoadingCopyWith<$Res> {
  __$$ContactStateLoadingCopyWithImpl(
      _$ContactStateLoading _value, $Res Function(_$ContactStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ContactStateLoading implements ContactStateLoading {
  const _$ContactStateLoading();

  @override
  String toString() {
    return 'ContactState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ContactStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ContactPerson> list) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactPerson> list)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactPerson> list)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContactStateInitial value) initial,
    required TResult Function(ContactStateLoading value) loading,
    required TResult Function(ContactStateLoaded value) loaded,
    required TResult Function(ContactStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContactStateInitial value)? initial,
    TResult? Function(ContactStateLoading value)? loading,
    TResult? Function(ContactStateLoaded value)? loaded,
    TResult? Function(ContactStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContactStateInitial value)? initial,
    TResult Function(ContactStateLoading value)? loading,
    TResult Function(ContactStateLoaded value)? loaded,
    TResult Function(ContactStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ContactStateLoading implements ContactState {
  const factory ContactStateLoading() = _$ContactStateLoading;
}

/// @nodoc
abstract class _$$ContactStateLoadedCopyWith<$Res> {
  factory _$$ContactStateLoadedCopyWith(_$ContactStateLoaded value,
          $Res Function(_$ContactStateLoaded) then) =
      __$$ContactStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ContactPerson> list});
}

/// @nodoc
class __$$ContactStateLoadedCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateLoaded>
    implements _$$ContactStateLoadedCopyWith<$Res> {
  __$$ContactStateLoadedCopyWithImpl(
      _$ContactStateLoaded _value, $Res Function(_$ContactStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$ContactStateLoaded(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ContactPerson>,
    ));
  }
}

/// @nodoc

class _$ContactStateLoaded implements ContactStateLoaded {
  const _$ContactStateLoaded(final List<ContactPerson> list) : _list = list;

  final List<ContactPerson> _list;
  @override
  List<ContactPerson> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'ContactState.loaded(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStateLoaded &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactStateLoadedCopyWith<_$ContactStateLoaded> get copyWith =>
      __$$ContactStateLoadedCopyWithImpl<_$ContactStateLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ContactPerson> list) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactPerson> list)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactPerson> list)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContactStateInitial value) initial,
    required TResult Function(ContactStateLoading value) loading,
    required TResult Function(ContactStateLoaded value) loaded,
    required TResult Function(ContactStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContactStateInitial value)? initial,
    TResult? Function(ContactStateLoading value)? loading,
    TResult? Function(ContactStateLoaded value)? loaded,
    TResult? Function(ContactStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContactStateInitial value)? initial,
    TResult Function(ContactStateLoading value)? loading,
    TResult Function(ContactStateLoaded value)? loaded,
    TResult Function(ContactStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ContactStateLoaded implements ContactState {
  const factory ContactStateLoaded(final List<ContactPerson> list) =
      _$ContactStateLoaded;

  List<ContactPerson> get list;
  @JsonKey(ignore: true)
  _$$ContactStateLoadedCopyWith<_$ContactStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContactStateErrorCopyWith<$Res> {
  factory _$$ContactStateErrorCopyWith(
          _$ContactStateError value, $Res Function(_$ContactStateError) then) =
      __$$ContactStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ContactStateErrorCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateError>
    implements _$$ContactStateErrorCopyWith<$Res> {
  __$$ContactStateErrorCopyWithImpl(
      _$ContactStateError _value, $Res Function(_$ContactStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ContactStateError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ContactStateError implements ContactStateError {
  const _$ContactStateError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ContactState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactStateErrorCopyWith<_$ContactStateError> get copyWith =>
      __$$ContactStateErrorCopyWithImpl<_$ContactStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ContactPerson> list) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactPerson> list)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactPerson> list)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContactStateInitial value) initial,
    required TResult Function(ContactStateLoading value) loading,
    required TResult Function(ContactStateLoaded value) loaded,
    required TResult Function(ContactStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContactStateInitial value)? initial,
    TResult? Function(ContactStateLoading value)? loading,
    TResult? Function(ContactStateLoaded value)? loaded,
    TResult? Function(ContactStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContactStateInitial value)? initial,
    TResult Function(ContactStateLoading value)? loading,
    TResult Function(ContactStateLoaded value)? loaded,
    TResult Function(ContactStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ContactStateError implements ContactState {
  const factory ContactStateError(final String error) = _$ContactStateError;

  String get error;
  @JsonKey(ignore: true)
  _$$ContactStateErrorCopyWith<_$ContactStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
