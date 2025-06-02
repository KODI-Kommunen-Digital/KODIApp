// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> events) loaded,
    required TResult Function(List<ProductModel> events) updated,
    required TResult Function(String msg) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> events)? loaded,
    TResult? Function(List<ProductModel> events)? updated,
    TResult? Function(String msg)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> events)? loaded,
    TResult Function(List<ProductModel> events)? updated,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventsStateInitial value) initial,
    required TResult Function(EventsStateLoading value) loading,
    required TResult Function(EventsStateLoaded value) loaded,
    required TResult Function(EventsStateUpdated value) updated,
    required TResult Function(EventsStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsStateInitial value)? initial,
    TResult? Function(EventsStateLoading value)? loading,
    TResult? Function(EventsStateLoaded value)? loaded,
    TResult? Function(EventsStateUpdated value)? updated,
    TResult? Function(EventsStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsStateInitial value)? initial,
    TResult Function(EventsStateLoading value)? loading,
    TResult Function(EventsStateLoaded value)? loaded,
    TResult Function(EventsStateUpdated value)? updated,
    TResult Function(EventsStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventsStateCopyWith<$Res> {
  factory $EventsStateCopyWith(
          EventsState value, $Res Function(EventsState) then) =
      _$EventsStateCopyWithImpl<$Res, EventsState>;
}

/// @nodoc
class _$EventsStateCopyWithImpl<$Res, $Val extends EventsState>
    implements $EventsStateCopyWith<$Res> {
  _$EventsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EventsStateInitialImplCopyWith<$Res> {
  factory _$$EventsStateInitialImplCopyWith(_$EventsStateInitialImpl value,
          $Res Function(_$EventsStateInitialImpl) then) =
      __$$EventsStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventsStateInitialImplCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$EventsStateInitialImpl>
    implements _$$EventsStateInitialImplCopyWith<$Res> {
  __$$EventsStateInitialImplCopyWithImpl(_$EventsStateInitialImpl _value,
      $Res Function(_$EventsStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EventsStateInitialImpl implements EventsStateInitial {
  const _$EventsStateInitialImpl();

  @override
  String toString() {
    return 'EventsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EventsStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> events) loaded,
    required TResult Function(List<ProductModel> events) updated,
    required TResult Function(String msg) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> events)? loaded,
    TResult? Function(List<ProductModel> events)? updated,
    TResult? Function(String msg)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> events)? loaded,
    TResult Function(List<ProductModel> events)? updated,
    TResult Function(String msg)? error,
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
    required TResult Function(EventsStateInitial value) initial,
    required TResult Function(EventsStateLoading value) loading,
    required TResult Function(EventsStateLoaded value) loaded,
    required TResult Function(EventsStateUpdated value) updated,
    required TResult Function(EventsStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsStateInitial value)? initial,
    TResult? Function(EventsStateLoading value)? loading,
    TResult? Function(EventsStateLoaded value)? loaded,
    TResult? Function(EventsStateUpdated value)? updated,
    TResult? Function(EventsStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsStateInitial value)? initial,
    TResult Function(EventsStateLoading value)? loading,
    TResult Function(EventsStateLoaded value)? loaded,
    TResult Function(EventsStateUpdated value)? updated,
    TResult Function(EventsStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class EventsStateInitial implements EventsState {
  const factory EventsStateInitial() = _$EventsStateInitialImpl;
}

/// @nodoc
abstract class _$$EventsStateLoadingImplCopyWith<$Res> {
  factory _$$EventsStateLoadingImplCopyWith(_$EventsStateLoadingImpl value,
          $Res Function(_$EventsStateLoadingImpl) then) =
      __$$EventsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventsStateLoadingImplCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$EventsStateLoadingImpl>
    implements _$$EventsStateLoadingImplCopyWith<$Res> {
  __$$EventsStateLoadingImplCopyWithImpl(_$EventsStateLoadingImpl _value,
      $Res Function(_$EventsStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EventsStateLoadingImpl implements EventsStateLoading {
  const _$EventsStateLoadingImpl();

  @override
  String toString() {
    return 'EventsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EventsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> events) loaded,
    required TResult Function(List<ProductModel> events) updated,
    required TResult Function(String msg) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> events)? loaded,
    TResult? Function(List<ProductModel> events)? updated,
    TResult? Function(String msg)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> events)? loaded,
    TResult Function(List<ProductModel> events)? updated,
    TResult Function(String msg)? error,
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
    required TResult Function(EventsStateInitial value) initial,
    required TResult Function(EventsStateLoading value) loading,
    required TResult Function(EventsStateLoaded value) loaded,
    required TResult Function(EventsStateUpdated value) updated,
    required TResult Function(EventsStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsStateInitial value)? initial,
    TResult? Function(EventsStateLoading value)? loading,
    TResult? Function(EventsStateLoaded value)? loaded,
    TResult? Function(EventsStateUpdated value)? updated,
    TResult? Function(EventsStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsStateInitial value)? initial,
    TResult Function(EventsStateLoading value)? loading,
    TResult Function(EventsStateLoaded value)? loaded,
    TResult Function(EventsStateUpdated value)? updated,
    TResult Function(EventsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EventsStateLoading implements EventsState {
  const factory EventsStateLoading() = _$EventsStateLoadingImpl;
}

/// @nodoc
abstract class _$$EventsStateLoadedImplCopyWith<$Res> {
  factory _$$EventsStateLoadedImplCopyWith(_$EventsStateLoadedImpl value,
          $Res Function(_$EventsStateLoadedImpl) then) =
      __$$EventsStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductModel> events});
}

/// @nodoc
class __$$EventsStateLoadedImplCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$EventsStateLoadedImpl>
    implements _$$EventsStateLoadedImplCopyWith<$Res> {
  __$$EventsStateLoadedImplCopyWithImpl(_$EventsStateLoadedImpl _value,
      $Res Function(_$EventsStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
  }) {
    return _then(_$EventsStateLoadedImpl(
      null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ));
  }
}

/// @nodoc

class _$EventsStateLoadedImpl implements EventsStateLoaded {
  const _$EventsStateLoadedImpl(final List<ProductModel> events)
      : _events = events;

  final List<ProductModel> _events;
  @override
  List<ProductModel> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'EventsState.loaded(events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_events));

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventsStateLoadedImplCopyWith<_$EventsStateLoadedImpl> get copyWith =>
      __$$EventsStateLoadedImplCopyWithImpl<_$EventsStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> events) loaded,
    required TResult Function(List<ProductModel> events) updated,
    required TResult Function(String msg) error,
  }) {
    return loaded(events);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> events)? loaded,
    TResult? Function(List<ProductModel> events)? updated,
    TResult? Function(String msg)? error,
  }) {
    return loaded?.call(events);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> events)? loaded,
    TResult Function(List<ProductModel> events)? updated,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(events);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventsStateInitial value) initial,
    required TResult Function(EventsStateLoading value) loading,
    required TResult Function(EventsStateLoaded value) loaded,
    required TResult Function(EventsStateUpdated value) updated,
    required TResult Function(EventsStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsStateInitial value)? initial,
    TResult? Function(EventsStateLoading value)? loading,
    TResult? Function(EventsStateLoaded value)? loaded,
    TResult? Function(EventsStateUpdated value)? updated,
    TResult? Function(EventsStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsStateInitial value)? initial,
    TResult Function(EventsStateLoading value)? loading,
    TResult Function(EventsStateLoaded value)? loaded,
    TResult Function(EventsStateUpdated value)? updated,
    TResult Function(EventsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class EventsStateLoaded implements EventsState {
  const factory EventsStateLoaded(final List<ProductModel> events) =
      _$EventsStateLoadedImpl;

  List<ProductModel> get events;

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventsStateLoadedImplCopyWith<_$EventsStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventsStateUpdatedImplCopyWith<$Res> {
  factory _$$EventsStateUpdatedImplCopyWith(_$EventsStateUpdatedImpl value,
          $Res Function(_$EventsStateUpdatedImpl) then) =
      __$$EventsStateUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductModel> events});
}

/// @nodoc
class __$$EventsStateUpdatedImplCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$EventsStateUpdatedImpl>
    implements _$$EventsStateUpdatedImplCopyWith<$Res> {
  __$$EventsStateUpdatedImplCopyWithImpl(_$EventsStateUpdatedImpl _value,
      $Res Function(_$EventsStateUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
  }) {
    return _then(_$EventsStateUpdatedImpl(
      null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ));
  }
}

/// @nodoc

class _$EventsStateUpdatedImpl implements EventsStateUpdated {
  const _$EventsStateUpdatedImpl(final List<ProductModel> events)
      : _events = events;

  final List<ProductModel> _events;
  @override
  List<ProductModel> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'EventsState.updated(events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsStateUpdatedImpl &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_events));

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventsStateUpdatedImplCopyWith<_$EventsStateUpdatedImpl> get copyWith =>
      __$$EventsStateUpdatedImplCopyWithImpl<_$EventsStateUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> events) loaded,
    required TResult Function(List<ProductModel> events) updated,
    required TResult Function(String msg) error,
  }) {
    return updated(events);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> events)? loaded,
    TResult? Function(List<ProductModel> events)? updated,
    TResult? Function(String msg)? error,
  }) {
    return updated?.call(events);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> events)? loaded,
    TResult Function(List<ProductModel> events)? updated,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(events);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventsStateInitial value) initial,
    required TResult Function(EventsStateLoading value) loading,
    required TResult Function(EventsStateLoaded value) loaded,
    required TResult Function(EventsStateUpdated value) updated,
    required TResult Function(EventsStateError value) error,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsStateInitial value)? initial,
    TResult? Function(EventsStateLoading value)? loading,
    TResult? Function(EventsStateLoaded value)? loaded,
    TResult? Function(EventsStateUpdated value)? updated,
    TResult? Function(EventsStateError value)? error,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsStateInitial value)? initial,
    TResult Function(EventsStateLoading value)? loading,
    TResult Function(EventsStateLoaded value)? loaded,
    TResult Function(EventsStateUpdated value)? updated,
    TResult Function(EventsStateError value)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class EventsStateUpdated implements EventsState {
  const factory EventsStateUpdated(final List<ProductModel> events) =
      _$EventsStateUpdatedImpl;

  List<ProductModel> get events;

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventsStateUpdatedImplCopyWith<_$EventsStateUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventsStateErrorImplCopyWith<$Res> {
  factory _$$EventsStateErrorImplCopyWith(_$EventsStateErrorImpl value,
          $Res Function(_$EventsStateErrorImpl) then) =
      __$$EventsStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$EventsStateErrorImplCopyWithImpl<$Res>
    extends _$EventsStateCopyWithImpl<$Res, _$EventsStateErrorImpl>
    implements _$$EventsStateErrorImplCopyWith<$Res> {
  __$$EventsStateErrorImplCopyWithImpl(_$EventsStateErrorImpl _value,
      $Res Function(_$EventsStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$EventsStateErrorImpl(
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EventsStateErrorImpl implements EventsStateError {
  const _$EventsStateErrorImpl(this.msg);

  @override
  final String msg;

  @override
  String toString() {
    return 'EventsState.error(msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsStateErrorImpl &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventsStateErrorImplCopyWith<_$EventsStateErrorImpl> get copyWith =>
      __$$EventsStateErrorImplCopyWithImpl<_$EventsStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> events) loaded,
    required TResult Function(List<ProductModel> events) updated,
    required TResult Function(String msg) error,
  }) {
    return error(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> events)? loaded,
    TResult? Function(List<ProductModel> events)? updated,
    TResult? Function(String msg)? error,
  }) {
    return error?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> events)? loaded,
    TResult Function(List<ProductModel> events)? updated,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventsStateInitial value) initial,
    required TResult Function(EventsStateLoading value) loading,
    required TResult Function(EventsStateLoaded value) loaded,
    required TResult Function(EventsStateUpdated value) updated,
    required TResult Function(EventsStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsStateInitial value)? initial,
    TResult? Function(EventsStateLoading value)? loading,
    TResult? Function(EventsStateLoaded value)? loaded,
    TResult? Function(EventsStateUpdated value)? updated,
    TResult? Function(EventsStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsStateInitial value)? initial,
    TResult Function(EventsStateLoading value)? loading,
    TResult Function(EventsStateLoaded value)? loaded,
    TResult Function(EventsStateUpdated value)? updated,
    TResult Function(EventsStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class EventsStateError implements EventsState {
  const factory EventsStateError(final String msg) = _$EventsStateErrorImpl;

  String get msg;

  /// Create a copy of EventsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventsStateErrorImplCopyWith<_$EventsStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
