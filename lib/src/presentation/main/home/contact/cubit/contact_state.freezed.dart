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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$ContactStateInitialImplCopyWith<$Res> {
  factory _$$ContactStateInitialImplCopyWith(_$ContactStateInitialImpl value,
          $Res Function(_$ContactStateInitialImpl) then) =
      __$$ContactStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContactStateInitialImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateInitialImpl>
    implements _$$ContactStateInitialImplCopyWith<$Res> {
  __$$ContactStateInitialImplCopyWithImpl(_$ContactStateInitialImpl _value,
      $Res Function(_$ContactStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ContactStateInitialImpl implements ContactStateInitial {
  const _$ContactStateInitialImpl();

  @override
  String toString() {
    return 'ContactState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStateInitialImpl);
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
  const factory ContactStateInitial() = _$ContactStateInitialImpl;
}

/// @nodoc
abstract class _$$ContactStateLoadingImplCopyWith<$Res> {
  factory _$$ContactStateLoadingImplCopyWith(_$ContactStateLoadingImpl value,
          $Res Function(_$ContactStateLoadingImpl) then) =
      __$$ContactStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContactStateLoadingImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateLoadingImpl>
    implements _$$ContactStateLoadingImplCopyWith<$Res> {
  __$$ContactStateLoadingImplCopyWithImpl(_$ContactStateLoadingImpl _value,
      $Res Function(_$ContactStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ContactStateLoadingImpl implements ContactStateLoading {
  const _$ContactStateLoadingImpl();

  @override
  String toString() {
    return 'ContactState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStateLoadingImpl);
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
  const factory ContactStateLoading() = _$ContactStateLoadingImpl;
}

/// @nodoc
abstract class _$$ContactStateLoadedImplCopyWith<$Res> {
  factory _$$ContactStateLoadedImplCopyWith(_$ContactStateLoadedImpl value,
          $Res Function(_$ContactStateLoadedImpl) then) =
      __$$ContactStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ContactPerson> list});
}

/// @nodoc
class __$$ContactStateLoadedImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateLoadedImpl>
    implements _$$ContactStateLoadedImplCopyWith<$Res> {
  __$$ContactStateLoadedImplCopyWithImpl(_$ContactStateLoadedImpl _value,
      $Res Function(_$ContactStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$ContactStateLoadedImpl(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ContactPerson>,
    ));
  }
}

/// @nodoc

class _$ContactStateLoadedImpl implements ContactStateLoaded {
  const _$ContactStateLoadedImpl(final List<ContactPerson> list) : _list = list;

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactStateLoadedImplCopyWith<_$ContactStateLoadedImpl> get copyWith =>
      __$$ContactStateLoadedImplCopyWithImpl<_$ContactStateLoadedImpl>(
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
      _$ContactStateLoadedImpl;

  List<ContactPerson> get list;
  @JsonKey(ignore: true)
  _$$ContactStateLoadedImplCopyWith<_$ContactStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContactStateErrorImplCopyWith<$Res> {
  factory _$$ContactStateErrorImplCopyWith(_$ContactStateErrorImpl value,
          $Res Function(_$ContactStateErrorImpl) then) =
      __$$ContactStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ContactStateErrorImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$ContactStateErrorImpl>
    implements _$$ContactStateErrorImplCopyWith<$Res> {
  __$$ContactStateErrorImplCopyWithImpl(_$ContactStateErrorImpl _value,
      $Res Function(_$ContactStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ContactStateErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ContactStateErrorImpl implements ContactStateError {
  const _$ContactStateErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ContactState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactStateErrorImplCopyWith<_$ContactStateErrorImpl> get copyWith =>
      __$$ContactStateErrorImplCopyWithImpl<_$ContactStateErrorImpl>(
          this, _$identity);

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
  const factory ContactStateError(final String error) = _$ContactStateErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$ContactStateErrorImplCopyWith<_$ContactStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
